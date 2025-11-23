#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

long long maxProduct(struct TreeNode* root){
    long long totalSum = 0;
    long long maxSum = 0;
    long long MOD = 1000000007;

    long long calculateSum(struct TreeNode* node) {
        if (!node) return 0;
        long long leftSum = calculateSum(node->left);
        long long rightSum = calculateSum(node->right);
        totalSum += node->val + leftSum + rightSum;
        return node->val + leftSum + rightSum;
    }

    long long findMaxProduct(struct TreeNode* node) {
        if (!node) return 0;

        long long leftSum = findMaxProductHelper(node->left);
        long long rightSum = findMaxProductHelper(node->right);

        return (leftSum > rightSum) ? leftSum : rightSum;
    }

    long long findMaxProductHelper(struct TreeNode* node) {
        if (!node) return 0;

        long long leftSum = calculateSubtreeSum(node->left);
        long long rightSum = calculateSubtreeSum(node->right);

        long long product1 = (totalSum - leftSum) * leftSum;
        long long product2 = (totalSum - rightSum) * rightSum;

        if (product1 > maxSum) maxSum = product1;
        if (product2 > maxSum) maxSum = product2;

        findMaxProductHelper(node->left);
        findMaxProductHelper(node->right);

        return (product1 > product2) ? product1 : product2;
    }

    long long calculateSubtreeSum(struct TreeNode* node) {
        if (!node) return 0;
        return node->val + calculateSubtreeSum(node->left) + calculateSubtreeSum(node->right);
    }

    calculateSum(root);
    findMaxProductHelper(root);

    return maxSum % MOD;
}