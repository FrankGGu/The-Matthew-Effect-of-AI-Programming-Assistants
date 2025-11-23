struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

int countPairs(struct TreeNode* root, int distance) {
    int count = 0;

    void dfs(struct TreeNode* node, int* levelCount) {
        if (!node) return;
        int levels[distance + 1] = {0};
        levels[0] = 1;

        for (int i = 0; i < distance; i++) {
            if (node->left) {
                dfs(node->left, levels);
            }
            if (node->right) {
                dfs(node->right, levels);
            }
        }

        for (int i = 0; i < distance; i++) {
            count += levels[i] * levels[distance - 1 - i];
        }

        for (int i = distance; i > 0; i--) {
            levels[i] = levels[i - 1];
        }
        levels[0] = 0;
    }

    dfs(root, &count);
    return count;
}