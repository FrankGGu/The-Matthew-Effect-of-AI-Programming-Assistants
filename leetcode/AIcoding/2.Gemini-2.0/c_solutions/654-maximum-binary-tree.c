#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode* constructMaximumBinaryTree(int* nums, int numsSize) {
    if (numsSize == 0) return NULL;

    int maxIndex = 0;
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] > nums[maxIndex]) {
            maxIndex = i;
        }
    }

    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    root->val = nums[maxIndex];

    int leftSize = maxIndex;
    int rightSize = numsSize - maxIndex - 1;

    if (leftSize > 0) {
        int* leftNums = (int*)malloc(sizeof(int) * leftSize);
        for (int i = 0; i < leftSize; i++) {
            leftNums[i] = nums[i];
        }
        root->left = constructMaximumBinaryTree(leftNums, leftSize);
        free(leftNums);
    } else {
        root->left = NULL;
    }

    if (rightSize > 0) {
        int* rightNums = (int*)malloc(sizeof(int) * rightSize);
        for (int i = 0; i < rightSize; i++) {
            rightNums[i] = nums[maxIndex + 1 + i];
        }
        root->right = constructMaximumBinaryTree(rightNums, rightSize);
        free(rightNums);
    } else {
        root->right = NULL;
    }

    return root;
}