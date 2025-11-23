#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

typedef struct {
    TreeNode *root;
} CBTInserter;

CBTInserter* cbtInserterCreate(TreeNode* root) {
    CBTInserter* obj = (CBTInserter*)malloc(sizeof(CBTInserter));
    obj->root = root;
    return obj;
}

int cBTInserterInsert(CBTInserter* obj, int v) {
    TreeNode* node = (TreeNode*)malloc(sizeof(TreeNode));
    node->val = v;
    node->left = NULL;
    node->right = NULL;
    if (obj->root == NULL) {
        obj->root = node;
        return v;
    }
    TreeNode* queue[1000];
    int front = 0, rear = 0;
    queue[rear++] = obj->root;
    while (front < rear) {
        TreeNode* curr = queue[front++];
        if (curr->left == NULL) {
            curr->left = node;
            return v;
        } else if (curr->right == NULL) {
            curr->right = node;
            return v;
        } else {
            queue[rear++] = curr->left;
            queue[rear++] = curr->right;
        }
    }
    return v;
}

TreeNode* cBTInserterGet_root(CBTInserter* obj) {
    return obj->root;
}