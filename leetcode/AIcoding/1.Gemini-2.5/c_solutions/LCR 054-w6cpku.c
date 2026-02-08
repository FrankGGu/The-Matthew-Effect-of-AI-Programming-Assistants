static int current_sum;

void dfs(struct TreeNode* node) {
    if (node == NULL) {
        return;
    }

    dfs(node->right);

    node->val += current_sum;
    current_sum = node->val;

    dfs(node->left);
}

struct TreeNode* convertBST(struct TreeNode* root) {
    current_sum = 0;
    dfs(root);
    return root;
}