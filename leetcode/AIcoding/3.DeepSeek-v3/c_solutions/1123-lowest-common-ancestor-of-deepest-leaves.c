/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

typedef struct {
    struct TreeNode* node;
    int depth;
} Result;

Result dfs(struct TreeNode* root) {
    if (root == NULL) {
        Result res = {NULL, 0};
        return res;
    }

    Result left = dfs(root->left);
    Result right = dfs(root->right);

    if (left.depth == right.depth) {
        Result res = {root, left.depth + 1};
        return res;
    } else if (left.depth > right.depth) {
        left.depth++;
        return left;
    } else {
        right.depth++;
        return right;
    }
}

struct TreeNode* lcaDeepestLeaves(struct TreeNode* root) {
    return dfs(root).node;
}