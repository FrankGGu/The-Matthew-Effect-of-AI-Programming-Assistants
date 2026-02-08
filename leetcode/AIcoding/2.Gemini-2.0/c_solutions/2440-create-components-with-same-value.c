#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int dfs(struct TreeNode* root, int target, int* count) {
    if (!root) {
        return 0;
    }

    int leftSum = dfs(root->left, target, count);
    int rightSum = dfs(root->right, target, count);

    int sum = leftSum + rightSum + root->val;

    if (sum == target) {
        (*count)++;
        return 0;
    } else {
        return sum;
    }
}

int componentValue(struct TreeNode* root, int target) {
    int count = 0;
    if (!root) return 0;
    dfs(root, target, &count);
    return count;
}