/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

struct Result {
    struct TreeNode* node;
    int depth;
};

struct Result dfs(struct TreeNode* root) {
    if (root == NULL) {
        struct Result res = {NULL, 0};
        return res;
    }

    struct Result left = dfs(root->left);
    struct Result right = dfs(root->right);

    if (left.depth > right.depth) {
        return (struct Result){left.node, left.depth + 1};
    }
    if (left.depth < right.depth) {
        return (struct Result){right.node, right.depth + 1};
    }

    return (struct Result){root, left.depth + 1};
}

struct TreeNode* subtreeWithAllDeepest(struct TreeNode* root) {
    return dfs(root).node;
}