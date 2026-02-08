#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int count = 0;

void dfs(struct TreeNode* root, int* sum, int* num) {
    if (root == NULL) {
        *sum = 0;
        *num = 0;
        return;
    }

    int leftSum = 0, leftNum = 0;
    int rightSum = 0, rightNum = 0;

    dfs(root->left, &leftSum, &leftNum);
    dfs(root->right, &rightSum, &rightNum);

    *sum = leftSum + rightSum + root->val;
    *num = leftNum + rightNum + 1;

    if (root->val == (*sum) / (*num)) {
        count++;
    }
}

int averageOfSubtree(struct TreeNode* root) {
    count = 0;
    int sum = 0, num = 0;
    dfs(root, &sum, &num);
    return count;
}