#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int dfs(struct TreeNode* root, int x) {
    if (!root) return 0;
    int sum = 0;
    if (root->val <= x) {
        sum += root->val;
    }
    sum += dfs(root->left, x);
    sum += dfs(root->right, x);
    return sum;
}

int* subtreeInversionSum(struct TreeNode* root, int* queries, int queriesSize, int* returnSize) {
    int* result = (int*)malloc(queriesSize * sizeof(int));
    *returnSize = queriesSize;
    for (int i = 0; i < queriesSize; i++) {
        result[i] = dfs(root, queries[i]);
    }
    return result;
}