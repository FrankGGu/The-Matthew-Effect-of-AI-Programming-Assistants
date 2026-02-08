#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

TreeNode* createNode(int val) {
    TreeNode* node = (TreeNode*)malloc(sizeof(TreeNode));
    node->val = val;
    node->left = NULL;
    node->right = NULL;
    return node;
}

void inorderTraversal(TreeNode* root, int** arr, int* index) {
    if (!root) return;
    inorderTraversal(root->left, arr, index);
    (*arr)[*index] = root->val;
    (*index)++;
    inorderTraversal(root->right, arr, index);
}

TreeNode* buildBalancedBST(int* arr, int start, int end) {
    if (start > end) return NULL;
    int mid = start + (end - start) / 2;
    TreeNode* node = createNode(arr[mid]);
    node->left = buildBalancedBST(arr, start, mid - 1);
    node->right = buildBalancedBST(arr, mid + 1, end);
    return node;
}

TreeNode* balanceBST(TreeNode* root) {
    int size = 0;
    TreeNode* temp = root;
    while (temp) {
        size++;
        temp = temp->left;
    }
    temp = root;
    while (temp) {
        size++;
        temp = temp->right;
    }

    int* arr = (int*)malloc(size * sizeof(int));
    int index = 0;
    inorderTraversal(root, &arr, &index);
    return buildBalancedBST(arr, 0, size - 1);
}