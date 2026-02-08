#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void inorderTraversal(struct TreeNode* root, int* arr, int* index) {
    if (root == NULL) return;
    inorderTraversal(root->left, arr, index);
    arr[(*index)++] = root->val;
    inorderTraversal(root->right, arr, index);
}

int countNodes(struct TreeNode* root) {
    if (root == NULL) return 0;
    return 1 + countNodes(root->left) + countNodes(root->right);
}

struct TreeNode* buildBalancedBST(int* arr, int start, int end) {
    if (start > end) return NULL;
    int mid = start + (end - start) / 2;
    struct TreeNode* node = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    node->val = arr[mid];
    node->left = buildBalancedBST(arr, start, mid - 1);
    node->right = buildBalancedBST(arr, mid + 1, end);
    return node;
}

struct TreeNode* balanceBST(struct TreeNode* root) {
    int n = countNodes(root);
    int* arr = (int*)malloc(n * sizeof(int));
    int index = 0;
    inorderTraversal(root, arr, &index);
    return buildBalancedBST(arr, 0, n - 1);
}