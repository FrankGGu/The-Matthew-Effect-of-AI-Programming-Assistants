#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

TreeNode* invertTree(TreeNode* root) {
    if (root == NULL) return NULL;
    TreeNode* left = invertTree(root->left);
    TreeNode* right = invertTree(root->right);
    root->left = right;
    root->right = left;
    return root;
}

int sumTree(TreeNode* root) {
    if (root == NULL) return 0;
    return root->val + sumTree(root->left) + sumTree(root->right);
}

int getSubtreeSum(TreeNode* root, int target) {
    if (root == NULL) return 0;
    int left = getSubtreeSum(root->left, target);
    int right = getSubtreeSum(root->right, target);
    if (root->val == target) {
        return root->val + left + right;
    }
    return left + right;
}

TreeNode* findSubtree(TreeNode* root, int target) {
    if (root == NULL) return NULL;
    if (root->val == target) return root;
    TreeNode* left = findSubtree(root->left, target);
    if (left != NULL) return left;
    return findSubtree(root->right, target);
}

int subtreeInversionSum(TreeNode* root, int target) {
    TreeNode* subtree = findSubtree(root, target);
    if (subtree == NULL) return 0;
    int originalSum = getSubtreeSum(root, target);
    invertTree(subtree);
    int newSum = getSubtreeSum(root, target);
    invertTree(subtree);
    return newSum - originalSum;
}