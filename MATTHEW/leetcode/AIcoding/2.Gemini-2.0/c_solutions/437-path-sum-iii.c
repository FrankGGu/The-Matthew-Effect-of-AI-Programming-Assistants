#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int pathSumHelper(struct TreeNode* root, long long targetSum, long long currentSum, int* count, int* prefixSum, int size) {
    if (!root) return 0;

    currentSum += root->val;

    int pathCount = 0;
    for (int i = 0; i < size; i++) {
        if (currentSum - prefixSum[i] == targetSum) {
            pathCount++;
        }
    }

    if (currentSum == targetSum) {
        pathCount++;
    }

    int* newPrefixSum = (int*)malloc((size + 1) * sizeof(int));
    for (int i = 0; i < size; i++) {
        newPrefixSum[i] = prefixSum[i];
    }
    newPrefixSum[size] = currentSum;

    *count += pathCount;

    pathSumHelper(root->left, targetSum, currentSum, count, newPrefixSum, size + 1);
    pathSumHelper(root->right, targetSum, currentSum, count, newPrefixSum, size + 1);

    free(newPrefixSum);

    return 0;
}

int pathSum(struct TreeNode* root, int targetSum) {
    int count = 0;
    int* prefixSum = NULL;
    pathSumHelper(root, (long long)targetSum, 0, &count, prefixSum, 0);
    return count;
}