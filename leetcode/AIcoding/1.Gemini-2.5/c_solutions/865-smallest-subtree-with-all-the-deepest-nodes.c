typedef struct {
    int depth;
    struct TreeNode *node;
} Result;

Result dfs(struct TreeNode *root) {
    if (root == NULL) {
        return (Result){0, NULL};
    }

    Result left_res = dfs(root->left);
    Result right_res = dfs(root->right);

    if (left_res.depth == right_res.depth) {
        return (Result){left_res.depth + 1, root};
    } else if (left_res.depth > right_res.depth) {
        return (Result){left_res.depth + 1, left_res.node};
    } else { // left_res.depth < right_res.depth
        return (Result){right_res.depth + 1, right_res.node};
    }
}

struct TreeNode* subtreeWithAllDeepest(struct TreeNode* root) {
    return dfs(root).node;
}