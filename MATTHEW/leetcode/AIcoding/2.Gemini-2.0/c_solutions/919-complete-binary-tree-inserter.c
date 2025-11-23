#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct TreeNode TreeNode;

typedef struct {
    TreeNode* root;
    TreeNode** queue;
    int head;
    int tail;
    int capacity;
} CBTInserter;

CBTInserter* cBTInserterCreate(TreeNode* root) {
    CBTInserter* inserter = (CBTInserter*)malloc(sizeof(CBTInserter));
    inserter->root = root;
    inserter->capacity = 10000;
    inserter->queue = (TreeNode**)malloc(sizeof(TreeNode*) * inserter->capacity);
    inserter->head = 0;
    inserter->tail = 0;

    TreeNode* q[10000];
    int q_head = 0;
    int q_tail = 0;
    q[q_tail++] = root;

    while (q_head < q_tail) {
        TreeNode* node = q[q_head++];
        if (node->left == NULL || node->right == NULL) {
            inserter->queue[inserter->tail++] = node;
        }
        if (node->left != NULL) {
            q[q_tail++] = node->left;
        }
        if (node->right != NULL) {
            q[q_tail++] = node->right;
        }
    }

    return inserter;
}

int cBTInserterInsert(CBTInserter* obj, int val) {
    TreeNode* newNode = (TreeNode*)malloc(sizeof(TreeNode));
    newNode->val = val;
    newNode->left = NULL;
    newNode->right = NULL;

    TreeNode* parent = obj->queue[obj->head];
    if (parent->left == NULL) {
        parent->left = newNode;
    } else {
        parent->right = newNode;
        obj->head++;
    }

    obj->queue[obj->tail++] = newNode;

    return parent->val;
}

TreeNode* cBTInserterGet_root(CBTInserter* obj) {
    return obj->root;
}

void cBTInserterFree(CBTInserter* obj) {
    free(obj->queue);
    free(obj);
}