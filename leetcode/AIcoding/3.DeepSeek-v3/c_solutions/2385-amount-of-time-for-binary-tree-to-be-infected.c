#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    int key;
    int value;
} HashMapEntry;

typedef struct {
    HashMapEntry *entries;
    int capacity;
    int size;
} HashMap;

HashMap* createHashMap(int capacity) {
    HashMap *map = (HashMap*)malloc(sizeof(HashMap));
    map->capacity = capacity;
    map->size = 0;
    map->entries = (HashMapEntry*)calloc(capacity, sizeof(HashMapEntry));
    for (int i = 0; i < capacity; i++) {
        map->entries[i].key = -1;
    }
    return map;
}

void put(HashMap *map, int key, int value) {
    int index = abs(key) % map->capacity;
    while (map->entries[index].key != -1 && map->entries[index].key != key) {
        index = (index + 1) % map->capacity;
    }
    map->entries[index].key = key;
    map->entries[index].value = value;
    map->size++;
}

int get(HashMap *map, int key) {
    int index = abs(key) % map->capacity;
    while (map->entries[index].key != -1) {
        if (map->entries[index].key == key) {
            return map->entries[index].value;
        }
        index = (index + 1) % map->capacity;
    }
    return -1;
}

void buildParentMap(struct TreeNode* root, HashMap *parentMap, struct TreeNode* parent) {
    if (!root) return;

    if (parent) {
        put(parentMap, root->val, parent->val);
    }

    buildParentMap(root->left, parentMap, root);
    buildParentMap(root->right, parentMap, root);
}

struct TreeNode* findStartNode(struct TreeNode* root, int start) {
    if (!root) return NULL;
    if (root->val == start) return root;

    struct TreeNode* left = findStartNode(root->left, start);
    if (left) return left;

    return findStartNode(root->right, start);
}

int amountOfTime(struct TreeNode* root, int start) {
    if (!root) return 0;

    HashMap *parentMap = createHashMap(100000);
    buildParentMap(root, parentMap, NULL);

    HashMap *visited = createHashMap(100000);

    struct TreeNode* startNode = findStartNode(root, start);

    struct TreeNode** queue = (struct TreeNode**)malloc(100000 * sizeof(struct TreeNode*));
    int front = 0, rear = 0;

    queue[rear++] = startNode;
    put(visited, start, 1);

    int time = -1;

    while (front < rear) {
        int levelSize = rear - front;
        time++;

        for (int i = 0; i < levelSize; i++) {
            struct TreeNode* current = queue[front++];

            if (current->left && get(visited, current->left->val) == -1) {
                put(visited, current->left->val, 1);
                queue[rear++] = current->left;
            }

            if (current->right && get(visited, current->right->val) == -1) {
                put(visited, current->right->val, 1);
                queue[rear++] = current->right;
            }

            int parentVal = get(parentMap, current->val);
            if (parentVal != -1 && get(visited, parentVal) == -1) {
                put(visited, parentVal, 1);
                struct TreeNode* parentNode = findStartNode(root, parentVal);
                queue[rear++] = parentNode;
            }
        }
    }

    free(parentMap->entries);
    free(parentMap);
    free(visited->entries);
    free(visited);
    free(queue);

    return time;
}