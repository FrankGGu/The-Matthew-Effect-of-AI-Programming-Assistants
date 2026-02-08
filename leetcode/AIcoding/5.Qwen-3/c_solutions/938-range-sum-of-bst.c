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

int rangeSumBST(TreeNode* root, int low, int high) {
    if (!root) return 0;
    int sum = 0;
    if (root->val >= low && root->val <= high) {
        sum += root->val;
    }
    sum += rangeSumBST(root->left, low, high);
    sum += rangeSumBST(root->right, low, high);
    return sum;
}