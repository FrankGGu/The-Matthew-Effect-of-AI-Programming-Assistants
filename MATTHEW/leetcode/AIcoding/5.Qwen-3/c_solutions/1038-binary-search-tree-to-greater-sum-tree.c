#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *right;
    struct TreeNode *left;
};

void dfs(struct TreeNode* root, int* sum) {
    if (root == NULL) return;
    dfs(root->right, sum);
    *sum += root->val;
    root->val = *sum;
    dfs(root->left, sum);
}

struct TreeNode* bstToGst(struct TreeNode* root) {
    int sum = 0;
    dfs(root, &sum);
    return root;
}