#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

bool hasPathSumHelper(struct TreeNode* root, int targetSum, int currentSum) {
    if (root == NULL) {
        return false;
    }

    currentSum += root->val;

    if (root->left == NULL && root->right == NULL) {
        return currentSum == targetSum;
    }

    return hasPathSumHelper(root->left, targetSum, currentSum) || hasPathSumHelper(root->right, targetSum, currentSum);
}

bool hasPathSum(struct TreeNode* root, int targetSum){
    if (root == NULL)
        return false;
    return hasPathSumHelper(root, targetSum, 0);
}