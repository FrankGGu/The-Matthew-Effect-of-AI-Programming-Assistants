#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

int cmpfunc(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

TreeNode* createTreeNode(int val) {
    TreeNode* node = (TreeNode*)malloc(sizeof(TreeNode));
    node->val = val;
    node->left = NULL;
    node->right = NULL;
    return node;
}

TreeNode* buildTree(int* nums, int numsSize) {
    if (numsSize == 0) return NULL;
    qsort(nums, numsSize, sizeof(int), cmpfunc);
    TreeNode* root = createTreeNode(nums[0]);
    for (int i = 1; i < numsSize; i++) {
        TreeNode* current = root;
        while (1) {
            if (nums[i] < current->val) {
                if (current->left == NULL) {
                    current->left = createTreeNode(nums[i]);
                    break;
                } else {
                    current = current->left;
                }
            } else {
                if (current->right == NULL) {
                    current->right = createTreeNode(nums[i]);
                    break;
                } else {
                    current = current->right;
                }
            }
        }
    }
    return root;
}

int numFactoredBinaryTrees(int* arr, int arrSize) {
    qsort(arr, arrSize, sizeof(int), cmpfunc);
    int* dp = (int*)calloc(arrSize, sizeof(int));
    int* indexMap = (int*)malloc(arrSize * sizeof(int));
    for (int i = 0; i < arrSize; i++) {
        indexMap[i] = i;
    }
    for (int i = 0; i < arrSize; i++) {
        dp[i] = 1;
        for (int j = 0; j < i; j++) {
            if (arr[i] % arr[j] == 0) {
                int target = arr[i] / arr[j];
                int k = 0;
                while (k < arrSize && arr[k] < target) {
                    k++;
                }
                if (k < arrSize && arr[k] == target) {
                    dp[i] += dp[j] * dp[k];
                }
            }
        }
    }
    int result = 0;
    for (int i = 0; i < arrSize; i++) {
        result += dp[i];
    }
    free(dp);
    free(indexMap);
    return result;
}