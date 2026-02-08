#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

TreeNode* constructMaximumBinaryTree(int* nums, int numsSize) {
    if (numsSize == 0) return NULL;

    int maxIndex = 0;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > nums[maxIndex]) {
            maxIndex = i;
        }
    }

    TreeNode* root = (TreeNode*)malloc(sizeof(TreeNode));
    root->val = nums[maxIndex];

    root->left = constructMaximumBinaryTree(nums, maxIndex);
    root->right = constructMaximumBinaryTree(nums + maxIndex + 1, numsSize - maxIndex - 1);

    return root;
}