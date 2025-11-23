#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int maxPathSumHelper(struct TreeNode* root, int* max_sum) {
    if (root == NULL) {
        return 0;
    }

    int left_sum = maxPathSumHelper(root->left, max_sum);
    int right_sum = maxPathSumHelper(root->right, max_sum);

    int max_single = (left_sum > 0 ? left_sum : 0) + (right_sum > 0 ? right_sum : 0) + root->val;
    int max_root = (left_sum > 0 ? left_sum : 0) > (right_sum > 0 ? right_sum : 0) ? (left_sum > 0 ? left_sum : 0) + root->val : (right_sum > 0 ? right_sum : 0) + root->val;

    int current_max = (max_single > max_root ? max_single : max_root) > root->val ? (max_single > max_root ? max_single : max_root) : root->val;

    if (current_max > *max_sum) {
        *max_sum = current_max;
    }

    return (left_sum > 0 ? left_sum : 0) > (right_sum > 0 ? right_sum : 0) ? (left_sum > 0 ? left_sum : 0) + root->val : (right_sum > 0 ? right_sum : 0) + root->val;
}

int maxPathSum(struct TreeNode* root) {
    int max_sum = INT_MIN;
    maxPathSumHelper(root, &max_sum);
    return max_sum;
}