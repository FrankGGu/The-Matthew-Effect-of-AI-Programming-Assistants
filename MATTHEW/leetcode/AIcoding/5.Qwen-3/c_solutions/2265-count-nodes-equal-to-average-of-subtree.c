#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int* averageOfSubtree(struct TreeNode* root, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * 1000);
    *returnSize = 0;

    int totalNodes = 0;

    typedef struct {
        int sum;
        int count;
    } Pair;

    Pair dfs(struct TreeNode* node) {
        if (!node) return (Pair){0, 0};

        Pair left = dfs(node->left);
        Pair right = dfs(node->right);

        int sum = left.sum + right.sum + node->val;
        int count = left.count + right.count + 1;

        if (sum / count == node->val) {
            result[*returnSize] = node->val;
            (*returnSize)++;
        }

        return (Pair){sum, count};
    }

    dfs(root);

    return result;
}