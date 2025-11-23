#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct {
    struct TreeNode *root;
    struct TreeNode **queue;
    int head;
    int tail;
    int capacity;
} CBTInserter;

CBTInserter* cBTInserterCreate(struct TreeNode* root) {
    CBTInserter* obj = (CBTInserter*)malloc(sizeof(CBTInserter));
    obj->root = root;
    obj->capacity = 10000;
    obj->queue = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * obj->capacity);
    obj->head = 0;
    obj->tail = 0;

    struct TreeNode** q = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * 10000);
    int h = 0, t = 0;
    q[t++] = root;

    while (h < t) {
        struct TreeNode* node = q[h++];
        if (node->left == NULL || node->right == NULL) {
            obj->queue[obj->tail++] = node;
        }
        if (node->left != NULL) {
            q[t++] = node->left;
        }
        if (node->right != NULL) {
            q[t++] = node->right;
        }
    }
    free(q);
    return obj;
}

int cBTInserterInsert(CBTInserter* obj, int val) {
    struct TreeNode* newNode = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    newNode->val = val;
    newNode->left = NULL;
    newNode->right = NULL;

    struct TreeNode* parent = obj->queue[obj->head];
    int parentVal = parent->val;

    if (parent->left == NULL) {
        parent->left = newNode;
        obj->queue[obj->tail++] = newNode;
    } else {
        parent->right = newNode;
        obj->queue[obj->tail++] = newNode;
        obj->head++;
    }

    return parentVal;
}

struct TreeNode* cBTInserterGet_root(CBTInserter* obj) {
    return obj->root;
}

void cBTInserterFree(CBTInserter* obj) {
    free(obj->queue);
    free(obj);
}