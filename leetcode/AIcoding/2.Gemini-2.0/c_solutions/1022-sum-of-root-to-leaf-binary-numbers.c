#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int sumRootToLeafHelper(struct TreeNode* root, int currentSum) {
    if (!root) return 0;

    currentSum = (currentSum << 1) | root->val;

    if (!root->left && !root->right) {
        return currentSum;
    }

    return sumRootToLeafHelper(root->left, currentSum) + sumRootToLeafHelper(root->right, currentSum);
}

int sumRootToLeaf(struct TreeNode* root) {
    return sumRootToLeafHelper(root, 0);
}