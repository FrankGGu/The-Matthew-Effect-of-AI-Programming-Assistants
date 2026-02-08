#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int pathSumHelper(struct TreeNode* root, int targetSum, long long currentSum) {
    if (!root) {
        return 0;
    }

    int count = 0;
    long long newSum = currentSum + root->val;

    if (newSum == targetSum) {
        count++;
    }

    count += pathSumHelper(root->left, targetSum, newSum);
    count += pathSumHelper(root->right, targetSum, newSum);

    return count;
}

int pathSum(struct TreeNode* root, int targetSum) {
    if (!root) {
        return 0;
    }

    int count = pathSumHelper(root, targetSum, 0);
    count += pathSum(root->left, targetSum);
    count += pathSum(root->right, targetSum);

    return count;
}