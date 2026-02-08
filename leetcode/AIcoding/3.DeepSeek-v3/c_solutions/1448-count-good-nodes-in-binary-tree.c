int goodNodesCount;

void dfs(struct TreeNode* node, int maxVal) {
    if (node == NULL) return;

    if (node->val >= maxVal) {
        goodNodesCount++;
        maxVal = node->val;
    }

    dfs(node->left, maxVal);
    dfs(node->right, maxVal);
}

int goodNodes(struct TreeNode* root) {
    goodNodesCount = 0;
    dfs(root, root->val);
    return goodNodesCount;
}