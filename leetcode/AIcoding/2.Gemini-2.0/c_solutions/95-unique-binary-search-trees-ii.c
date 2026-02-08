#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

struct TreeNode** generateTrees(int n, int* returnSize){
    if (n == 0) {
        *returnSize = 0;
        return NULL;
    }

    struct TreeNode*** dp = (struct TreeNode***)malloc((n + 1) * sizeof(struct TreeNode**));
    int* sizes = (int*)malloc((n + 1) * sizeof(int));

    for (int i = 0; i <= n; i++) {
        dp[i] = (struct TreeNode**)malloc((n + 1) * sizeof(struct TreeNode*));
        sizes[i] = 0;
    }

    sizes[0] = 1;
    dp[0][0] = NULL;

    for (int len = 1; len <= n; len++) {
        for (int i = 1; i <= n - len + 1; i++) {
            int j = i + len - 1;
            for (int root = i; root <= j; root++) {
                int leftSize = root - i;
                int rightSize = j - root;

                if (sizes[leftSize] == 0) {
                    dp[len][sizes[len]] = (struct TreeNode*)malloc(sizeof(struct TreeNode));
                    dp[len][sizes[len]]->val = root;
                    dp[len][sizes[len]]->left = NULL;
                    dp[len][sizes[len]]->right = NULL;
                    sizes[len]++;
                    continue;
                }

                if (sizes[rightSize] == 0) {
                    for (int k = 0; k < sizes[leftSize]; k++) {
                        struct TreeNode* newRoot = (struct TreeNode*)malloc(sizeof(struct TreeNode));
                        newRoot->val = root;
                        newRoot->left = copyTree(dp[leftSize][k], i);
                        newRoot->right = NULL;
                        dp[len][sizes[len]++] = newRoot;
                    }
                    continue;
                }

                for (int k = 0; k < sizes[leftSize]; k++) {
                    for (int l = 0; l < sizes[rightSize]; l++) {
                        struct TreeNode* newRoot = (struct TreeNode*)malloc(sizeof(struct TreeNode));
                        newRoot->val = root;
                        newRoot->left = copyTree(dp[leftSize][k], i);
                        newRoot->right = copyTree(dp[rightSize][l], root + 1);
                        dp[len][sizes[len]++] = newRoot;
                    }
                }
            }
        }
    }

    struct TreeNode** result = (struct TreeNode**)malloc(sizes[n] * sizeof(struct TreeNode*));
    for (int i = 0; i < sizes[n]; i++) {
        result[i] = dp[n][i];
    }

    *returnSize = sizes[n];

    for (int i = 0; i <= n; i++) {
        free(dp[i]);
    }
    free(dp);
    free(sizes);

    return result;
}

struct TreeNode* copyTree(struct TreeNode* root, int offset) {
    if (root == NULL) {
        return NULL;
    }

    struct TreeNode* newRoot = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    newRoot->val = root->val + offset - 1;
    newRoot->left = copyTree(root->left, offset);
    newRoot->right = copyTree(root->right, offset);

    return newRoot;
}