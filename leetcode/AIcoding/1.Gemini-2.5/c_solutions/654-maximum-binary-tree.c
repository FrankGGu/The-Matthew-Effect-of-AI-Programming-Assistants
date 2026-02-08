#include <stdlib.h> // Required for malloc

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* buildTree(int* nums, int start, int end) {
    if (start > end) {
        return NULL;
    }

    int maxVal = nums[start];
    int maxIdx = start;
    for (int i = start + 1; i <= end; i++) {
        if (nums[i] > maxVal) {
            maxVal = nums[i];
            maxIdx = i;
        }
    }

    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = maxVal;
    root->left = buildTree(nums, start, maxIdx - 1);
    root->right = buildTree(nums, maxIdx + 1, end);

    return root;
}

struct TreeNode* constructMaximumBinaryTree(int* nums, int numsSize) {
    return buildTree(nums, 0, numsSize - 1);
}