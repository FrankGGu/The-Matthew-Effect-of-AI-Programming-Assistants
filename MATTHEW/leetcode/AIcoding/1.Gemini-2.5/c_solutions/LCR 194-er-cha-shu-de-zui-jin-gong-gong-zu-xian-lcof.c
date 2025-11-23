struct TreeNode* lowestCommonAncestor(struct TreeNode* root, struct TreeNode* p, struct TreeNode* q) {
    if (root == NULL || root == p || root == q) {
        return root;
    }

    struct TreeNode* left_lca = lowestCommonAncestor(root->left, p, q);
    struct TreeNode* right_lca = lowestCommonAncestor(root->right, p, q);

    if (left_lca != NULL && right_lca != NULL) {
        return root;
    } else if (left_lca != NULL) {
        return left_lca;
    } else {
        return right_lca;
    }
}