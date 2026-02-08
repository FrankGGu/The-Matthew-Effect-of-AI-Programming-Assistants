int countPalindromicPaths(struct TreeNode* root) {
    int count = 0;

    void dfs(struct TreeNode* node, int* freq) {
        if (!node) return;

        freq[node->val]++;

        if (!node->left && !node->right) {
            int oddCount = 0;
            for (int i = 0; i < 10; i++) {
                if (freq[i] % 2 != 0) oddCount++;
            }
            if (oddCount <= 1) count++;
        } else {
            dfs(node->left, freq);
            dfs(node->right, freq);
        }

        freq[node->val]--;
    }

    int freq[10] = {0};
    dfs(root, freq);

    return count;
}