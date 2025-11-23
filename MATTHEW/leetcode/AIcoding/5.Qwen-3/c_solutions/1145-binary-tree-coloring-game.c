#include <stdio.h>
#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct TreeNode TreeNode;

int dfs(TreeNode* root, int x) {
    if (!root) return 0;
    int left = dfs(root->left, x);
    int right = dfs(root->right, x);
    if (root->val == x) {
        return left + right + 1;
    }
    return left + right + 1;
}

void find(TreeNode* root, int x, int* left, int* right) {
    if (!root) return;
    if (root->val == x) {
        *left = dfs(root->left, x);
        *right = dfs(root->right, x);
        return;
    }
    find(root->left, x, left, right);
    find(root->right, x, left, right);
}

int btreeGameWinningMove(struct TreeNode* root, int n, int x) {
    int left = 0, right = 0;
    find(root, x, &left, &right);
    int total = left + right + 1;
    return (left > total / 2) || (right > total / 2) || (n - total > total / 2);
}