/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

struct TreeNode* construct(int* nums, int left, int right) {
    if (left > right) return NULL;

    int maxIndex = left;
    for (int i = left + 1; i <= right; i++) {
        if (nums[i] > nums[maxIndex]) {
            maxIndex = i;
        }
    }

    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = nums[maxIndex];
    root->left = construct(nums, left, maxIndex - 1);
    root->right = construct(nums, maxIndex + 1, right);

    return root;
}

struct TreeNode* constructMaximumBinaryTree(int* nums, int numsSize) {
    return construct(nums, 0, numsSize - 1);
}