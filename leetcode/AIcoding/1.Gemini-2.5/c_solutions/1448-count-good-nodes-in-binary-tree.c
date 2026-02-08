int countGoodNodes(struct TreeNode* root);
int dfs(struct TreeNode* node, int maxVal);

int countGoodNodes(struct TreeNode* root) {
    if (root == NULL) {
        return 0;
    }
    return dfs(root, root->val);
}

int dfs(struct TreeNode* node, int maxVal) {
    if (node == NULL) {
        return 0;
    }

    int currentGoodNodes = 0;
    if (node->val >= maxVal) {
        currentGoodNodes = 1;
        maxVal = node->val;
    }

    currentGoodNodes += dfs(node->left, maxVal);
    currentGoodNodes += dfs(node->right, maxVal);

    return currentGoodNodes;
}