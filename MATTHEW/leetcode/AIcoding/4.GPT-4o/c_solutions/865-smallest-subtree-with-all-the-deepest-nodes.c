int maxDepth(struct TreeNode* root) {
    if (!root) return 0;
    int leftDepth = maxDepth(root->left);
    int rightDepth = maxDepth(root->right);
    return leftDepth > rightDepth ? leftDepth + 1 : rightDepth + 1;
}

struct TreeNode* subtreeWithAllDeepest(struct TreeNode* root) {
    if (!root) return NULL;

    int leftDepth = maxDepth(root->left);
    int rightDepth = maxDepth(root->right);

    if (leftDepth == rightDepth) return root;
    if (leftDepth > rightDepth) return subtreeWithAllDeepest(root->left);
    return subtreeWithAllDeepest(root->right);
}