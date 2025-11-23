#include <stddef.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* sortedArrayToBSTRecursive(int* nums, int start, int end) {
    if (start > end) {
        return NULL;
    }

    int mid = start + (end - start) / 2;
    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = nums[mid];
    root->left = sortedArrayToBSTRecursive(nums, start, mid - 1);
    root->right = sortedArrayToBSTRecursive(nums, mid + 1, end);

    return root;
}

struct TreeNode* sortedArrayToBST(int* nums, int numsSize) {
    if (numsSize == 0) {
        return NULL;
    }
    return sortedArrayToBSTRecursive(nums, 0, numsSize - 1);
}