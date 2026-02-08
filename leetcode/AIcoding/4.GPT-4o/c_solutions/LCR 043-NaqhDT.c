#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct CBTInserter {
    struct TreeNode **nodes;
    int size;
};

struct CBTInserter* cbtInserterCreate(struct TreeNode* root) {
    struct CBTInserter* inserter = (struct CBTInserter*)malloc(sizeof(struct CBTInserter));
    inserter->nodes = (struct TreeNode**)malloc(10000 * sizeof(struct TreeNode*));
    inserter->size = 0;
    struct TreeNode** queue = (struct TreeNode**)malloc(10000 * sizeof(struct TreeNode*));
    int front = 0, rear = 0;

    queue[rear++] = root;
    while (front < rear) {
        struct TreeNode* node = queue[front++];
        inserter->nodes[inserter->size++] = node;
        if (node->left) queue[rear++] = node->left;
        if (node->right) queue[rear++] = node->right;
    }

    free(queue);
    return inserter;
}

int cbtInserterInsert(struct CBTInserter* obj, int v) {
    struct TreeNode* newNode = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    newNode->val = v;
    newNode->left = newNode->right = NULL;

    struct TreeNode* parent = obj->nodes[(obj->size - 1) / 2];
    if (!parent->left) {
        parent->left = newNode;
    } else {
        parent->right = newNode;
    }

    obj->nodes[obj->size++] = newNode;
    return parent->val;
}

struct TreeNode* cbtInserterGet_root(struct CBTInserter* obj) {
    return obj->nodes[0];
}

void cbtInserterFree(struct CBTInserter* obj) {
    free(obj->nodes);
    free(obj);
}