struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

#include <stdio.h>
#include <stdlib.h>

struct ListNode {
    struct TreeNode **nodes;
    int size;
    int capacity;
};

struct ListNode* createListNode(int capacity) {
    struct ListNode* list = (struct ListNode*)malloc(sizeof(struct ListNode));
    list->nodes = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * capacity);
    list->size = 0;
    list->capacity = capacity;
    return list;
}

void addNode(struct ListNode* list, struct TreeNode* node) {
    if (list->size == list->capacity) {
        list->capacity *= 2;
        list->nodes = (struct TreeNode**)realloc(list->nodes, sizeof(struct TreeNode*) * list->capacity);
    }
    list->nodes[list->size++] = node;
}

void freeList(struct ListNode* list) {
    free(list->nodes);
    free(list);
}

struct ListNode** zigzagLevelOrder(struct TreeNode* root, int* returnSize) {
    if (!root) {
        *returnSize = 0;
        return NULL;
    }

    struct ListNode** result = (struct ListNode**)malloc(sizeof(struct ListNode*) * 100);
    int front = 0, rear = 0;
    struct ListNode* currentLevel = createListNode(100);
    struct ListNode* nextLevel = createListNode(100);
    int leftToRight = 1;

    addNode(currentLevel, root);
    while (currentLevel->size > 0) {
        int currentSize = currentLevel->size;
        struct ListNode* levelNodes = createListNode(currentSize);

        for (int i = 0; i < currentSize; i++) {
            struct TreeNode* node = currentLevel->nodes[i];
            addNode(levelNodes, node);
            if (leftToRight) {
                if (node->left) addNode(nextLevel, node->left);
                if (node->right) addNode(nextLevel, node->right);
            } else {
                if (node->right) addNode(nextLevel, node->right);
                if (node->left) addNode(nextLevel, node->left);
            }
        }
        result[rear++] = levelNodes;
        front++;
        struct ListNode* temp = currentLevel;
        currentLevel = nextLevel;
        nextLevel = temp;
        nextLevel->size = 0;
        leftToRight = !leftToRight;
    }

    *returnSize = rear;
    freeList(currentLevel);
    freeList(nextLevel);
    return result;
}