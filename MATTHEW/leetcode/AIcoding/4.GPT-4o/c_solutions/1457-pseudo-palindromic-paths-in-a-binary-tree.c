int isPseudoPalindromic(int counts[10]) {
    int oddCount = 0;
    for (int i = 0; i < 10; i++) {
        if (counts[i] % 2 == 1) {
            oddCount++;
        }
    }
    return oddCount <= 1;
}

void dfs(struct TreeNode* node, int counts[10], int* result) {
    if (!node) return;

    counts[node->val]++;

    if (!node->left && !node->right) {
        if (isPseudoPalindromic(counts)) {
            (*result)++;
        }
    } else {
        dfs(node->left, counts, result);
        dfs(node->right, counts, result);
    }

    counts[node->val]--;
}

int pseudoPalindromicPaths(struct TreeNode* root) {
    int counts[10] = {0};
    int result = 0;
    dfs(root, counts, &result);
    return result;
}