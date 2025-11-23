#include <stdlib.h>
#include <time.h>

#define MAX_LEVEL 16

typedef struct Node {
    int val;
    struct Node** forward;
} Node;

typedef struct {
    int level;
    Node* header;
} Skiplist;

Node* createNode(int level, int val) {
    Node* node = (Node*)malloc(sizeof(Node));
    node->val = val;
    node->forward = (Node**)malloc(sizeof(Node*) * (level + 1));
    for (int i = 0; i <= level; i++) {
        node->forward[i] = NULL;
    }
    return node;
}

Skiplist* skiplistCreate() {
    Skiplist* obj = (Skiplist*)malloc(sizeof(Skiplist));
    obj->level = 0;
    obj->header = createNode(MAX_LEVEL, -1);
    srand(time(NULL));
    return obj;
}

int randomLevel() {
    int level = 0;
    while (rand() % 2 && level < MAX_LEVEL - 1) {
        level++;
    }
    return level;
}

bool skiplistSearch(Skiplist* obj, int target) {
    Node* curr = obj->header;
    for (int i = obj->level; i >= 0; i--) {
        while (curr->forward[i] && curr->forward[i]->val < target) {
            curr = curr->forward[i];
        }
    }
    curr = curr->forward[0];
    return curr && curr->val == target;
}

void skiplistAdd(Skiplist* obj, int num) {
    Node* update[MAX_LEVEL + 1];
    Node* curr = obj->header;

    for (int i = obj->level; i >= 0; i--) {
        while (curr->forward[i] && curr->forward[i]->val < num) {
            curr = curr->forward[i];
        }
        update[i] = curr;
    }

    int newLevel = randomLevel();
    if (newLevel > obj->level) {
        for (int i = obj->level + 1; i <= newLevel; i++) {
            update[i] = obj->header;
        }
        obj->level = newLevel;
    }

    Node* newNode = createNode(newLevel, num);
    for (int i = 0; i <= newLevel; i++) {
        newNode->forward[i] = update[i]->forward[i];
        update[i]->forward[i] = newNode;
    }
}

bool skiplistErase(Skiplist* obj, int num) {
    Node* update[MAX_LEVEL + 1];
    Node* curr = obj->header;

    for (int i = obj->level; i >= 0; i--) {
        while (curr->forward[i] && curr->forward[i]->val < num) {
            curr = curr->forward[i];
        }
        update[i] = curr;
    }

    curr = curr->forward[0];
    if (!curr || curr->val != num) {
        return false;
    }

    for (int i = 0; i <= obj->level; i++) {
        if (update[i]->forward[i] != curr) {
            break;
        }
        update[i]->forward[i] = curr->forward[i];
    }

    free(curr->forward);
    free(curr);

    while (obj->level > 0 && obj->header->forward[obj->level] == NULL) {
        obj->level--;
    }

    return true;
}

void skiplistFree(Skiplist* obj) {
    Node* curr = obj->header->forward[0];
    while (curr) {
        Node* temp = curr;
        curr = curr->forward[0];
        free(temp->forward);
        free(temp);
    }
    free(obj->header->forward);
    free(obj->header);
    free(obj);
}