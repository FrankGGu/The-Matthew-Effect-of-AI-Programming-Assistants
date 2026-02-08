#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* insert(struct TreeNode* root, int val) {
    if (root == NULL) {
        struct TreeNode* newNode = (struct TreeNode*)malloc(sizeof(struct TreeNode));
        newNode->val = val;
        newNode->left = NULL;
        newNode->right = NULL;
        return newNode;
    }

    if (val < root->val) {
        root->left = insert(root->left, val);
    } else {
        root->right = insert(root->right, val);
    }

    return root;
}

int* inorderTraversal(struct TreeNode* root, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * 1000);
    int count = 0;

    struct TreeNode** stack = (struct TreeNode**)malloc(sizeof(struct TreeNode*) * 1000);
    int top = -1;

    struct TreeNode* curr = root;

    while (curr != NULL || top != -1) {
        while (curr != NULL) {
            stack[++top] = curr;
            curr = curr->left;
        }

        curr = stack[top--];
        result[count++] = curr->val;
        curr = curr->right;
    }

    free(stack);
    *returnSize = count;
    return result;
}

int* solve(int* order, int orderSize, int* returnSize){
    struct TreeNode* root = NULL;
    for (int i = 0; i < orderSize; i++) {
        root = insert(root, order[i]);
    }

    return inorderTraversal(root, returnSize);
}