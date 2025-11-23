#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int* pathSumBST(TreeNode* root, int targetSum, int* returnSize);

int* pathSum(TreeNode* root, int targetSum, int* returnSize) {
    return pathSumBST(root, targetSum, returnSize);
}

int* pathSumBST(TreeNode* root, int targetSum, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * 1000);
    *returnSize = 0;

    void dfs(TreeNode* node, long long currentSum, int* prefixSums, int prefixSize) {
        if (!node) return;

        currentSum += node->val;

        // Check if currentSum equals targetSum
        if (currentSum == targetSum) {
            result[*returnSize] = 1;
            (*returnSize)++;
        }

        // Check for all previous prefix sums
        for (int i = 0; i < prefixSize; i++) {
            if (currentSum - prefixSums[i] == targetSum) {
                result[*returnSize] = 1;
                (*returnSize)++;
            }
        }

        // Add currentSum to prefixSums
        int* newPrefixSums = (int*)malloc(sizeof(int) * (prefixSize + 1));
        for (int i = 0; i < prefixSize; i++) {
            newPrefixSums[i] = prefixSums[i];
        }
        newPrefixSums[prefixSize] = currentSum;

        dfs(node->left, currentSum, newPrefixSums, prefixSize + 1);
        dfs(node->right, currentSum, newPrefixSums, prefixSize + 1);

        free(newPrefixSums);
    }

    dfs(root, 0, NULL, 0);

    return result;
}