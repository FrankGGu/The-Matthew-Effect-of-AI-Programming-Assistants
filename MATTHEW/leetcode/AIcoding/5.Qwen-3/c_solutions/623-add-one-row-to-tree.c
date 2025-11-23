#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* addOneRow(struct TreeNode* root, int val, int depth) {
    if (depth == 1) {
        struct TreeNode* newRoot = (struct TreeNode*)malloc(sizeof(struct TreeNode));
        newRoot->val = val;
        newRoot->left = root;
        newRoot->right = NULL;
        return newRoot;
    }

    struct TreeNode* queue[10000];
    int front = 0, rear = 0;
    queue[rear++] = root;

    int currentDepth = 1;
    while (currentDepth < depth - 1) {
        int size = rear - front;
        for (int i = 0; i < size; i++) {
            struct TreeNode* node = queue[front++];
            if (node->left) queue[rear++] = node->left;
            if (node->right) queue[rear++] = node->right;
        }
        currentDepth++;
    }

    while (front < rear) {
        struct TreeNode* node = queue[front++];
        struct TreeNode* left = (struct TreeNode*)malloc(sizeof(struct TreeNode));
        left->val = val;
        left->left = node->left;
        left->right = NULL;
        node->left = left;

        struct TreeNode* right = (struct TreeNode*)malloc(sizeof(struct TreeNode));
        right->val = val;
        right->right = node->right;
        right->left = NULL;
        node->right = right;
    }

    return root;
}