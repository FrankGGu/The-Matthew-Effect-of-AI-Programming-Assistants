#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

bool isCousins(struct TreeNode* root, int x, int y) {
    if (!root) return false;

    struct TreeNode* x_parent = NULL;
    struct TreeNode* y_parent = NULL;
    int x_depth = -1;
    int y_depth = -1;

    void dfs(struct TreeNode* node, struct TreeNode* parent, int depth) {
        if (!node) return;

        if (node->val == x) {
            x_parent = parent;
            x_depth = depth;
        } else if (node->val == y) {
            y_parent = parent;
            y_depth = depth;
        }

        if (x_depth != -1 && y_depth != -1) return;

        dfs(node->left, node, depth + 1);
        dfs(node->right, node, depth + 1);
    }

    dfs(root, NULL, 0);

    return (x_depth == y_depth && x_parent != y_parent);
}