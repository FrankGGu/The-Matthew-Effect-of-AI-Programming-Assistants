int sum;

void dfs(struct TreeNode* node, struct TreeNode* parent, struct TreeNode* grandparent) {
    if (!node) return;
    if (grandparent && grandparent->val % 2 == 0) {
        sum += node->val;
    }
    dfs(node->left, node, parent);
    dfs(node->right, node, parent);
}

int sumEvenGrandparent(struct TreeNode* root) {
    sum = 0;
    dfs(root, NULL, NULL);
    return sum;
}