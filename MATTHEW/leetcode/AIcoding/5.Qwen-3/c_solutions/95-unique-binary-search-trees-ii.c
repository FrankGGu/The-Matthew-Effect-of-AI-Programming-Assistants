#include <stdio.h>
#include <stdlib.h>

typedef struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

TreeNode* createNode(int val) {
    TreeNode* node = (TreeNode*)malloc(sizeof(TreeNode));
    node->val = val;
    node->left = NULL;
    node->right = NULL;
    return node;
}

TreeNode** generateTrees(int n, int* returnSize) {
    if (n == 0) {
        *returnSize = 0;
        return NULL;
    }

    TreeNode** result = (TreeNode**)malloc(sizeof(TreeNode*));
    *returnSize = 0;

    int* nums = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 1; i <= n; i++) {
        nums[i - 1] = i;
    }

    int** dp = (int**)malloc((n + 1) * sizeof(int*));
    for (int i = 0; i <= n; i++) {
        dp[i] = (int*)malloc((n + 1) * sizeof(int));
    }

    for (int i = 0; i <= n; i++) {
        dp[i][i] = 1;
    }

    for (int length = 2; length <= n; length++) {
        for (int start = 1; start <= n - length + 1; start++) {
            int end = start + length - 1;
            dp[start][end] = 0;
            for (int root = start; root <= end; root++) {
                int leftCount = dp[start][root - 1];
                int rightCount = dp[root + 1][end];
                dp[start][end] += leftCount * rightCount;
            }
        }
    }

    *returnSize = dp[1][n];

    TreeNode*** treeList = (TreeNode***)malloc(dp[1][n] * sizeof(TreeNode**));

    for (int i = 0; i < dp[1][n]; i++) {
        treeList[i] = (TreeNode**)malloc(sizeof(TreeNode*));
    }

    int index = 0;

    void buildTree(int start, int end, TreeNode*** list, int* idx, int* nums) {
        if (start > end) {
            list[*idx] = (TreeNode*)malloc(sizeof(TreeNode));
            list[*idx]->val = 0;
            list[*idx]->left = NULL;
            list[*idx]->right = NULL;
            (*idx)++;
            return;
        }

        for (int root = start; root <= end; root++) {
            int leftCount = dp[start][root - 1];
            int rightCount = dp[root + 1][end];

            TreeNode** leftTrees = (TreeNode**)malloc(leftCount * sizeof(TreeNode*));
            TreeNode** rightTrees = (TreeNode**)malloc(rightCount * sizeof(TreeNode*));

            buildTree(start, root - 1, &leftTrees, &leftCount, nums);
            buildTree(root + 1, end, &rightTrees, &rightCount, nums);

            for (int i = 0; i < leftCount; i++) {
                for (int j = 0; j < rightCount; j++) {
                    TreeNode* node = createNode(nums[root - 1]);
                    node->left = leftTrees[i];
                    node->right = rightTrees[j];
                    list[*idx] = node;
                    (*idx)++;
                }
            }

            free(leftTrees);
            free(rightTrees);
        }
    }

    buildTree(1, n, treeList, &index, nums);

    free(nums);
    for (int i = 0; i <= n; i++) {
        free(dp[i]);
    }
    free(dp);

    return treeList;
}