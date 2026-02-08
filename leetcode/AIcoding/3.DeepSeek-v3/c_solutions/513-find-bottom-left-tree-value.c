#include <stdlib.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

void dfs(struct TreeNode* root, int depth, int* maxDepth, int* result) {
    if (root == NULL) return;

    if (depth > *maxDepth) {
        *maxDepth = depth;
        *result = root->val;
    }

    dfs(root->left, depth + 1, maxDepth, result);
    dfs(root->right, depth + 1, maxDepth, result);
}

int findBottomLeftValue(struct TreeNode* root) {
    int maxDepth = -1;
    int result = 0;
    dfs(root, 0, &maxDepth, &result);
    return result;
}