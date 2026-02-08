#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void inorder(struct TreeNode* root, int* arr, int* size) {
    if (!root) return;
    inorder(root->left, arr, size);
    arr[(*size)++] = root->val;
    inorder(root->right, arr, size);
}

struct TreeNode* buildBST(int* arr, int start, int end) {
    if (start > end) return NULL;
    int mid = (start + end) / 2;
    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = arr[mid];
    root->left = buildBST(arr, start, mid - 1);
    root->right = buildBST(arr, mid + 1, end);
    return root;
}

struct TreeNode* balanceBST(struct TreeNode* root) {
    int* arr = (int*)malloc(sizeof(int) * 10000);
    int size = 0;
    inorder(root, arr, &size);
    struct TreeNode* balancedRoot = buildBST(arr, 0, size - 1);
    free(arr);
    return balancedRoot;
}