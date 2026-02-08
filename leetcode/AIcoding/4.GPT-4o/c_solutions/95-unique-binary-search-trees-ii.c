struct TreeNode** generateTrees(int n, int* returnSize) {
    if (n == 0) {
        *returnSize = 0;
        return NULL;
    }

    struct TreeNode*** dp = (struct TreeNode***)malloc((n + 1) * sizeof(struct TreeNode**));
    int* sizes = (int*)malloc((n + 1) * sizeof(int));

    dp[0] = (struct TreeNode**)malloc(sizeof(struct TreeNode*));
    dp[0][0] = NULL;
    sizes[0] = 1;

    for (int i = 1; i <= n; i++) {
        dp[i] = (struct TreeNode**)malloc(10000 * sizeof(struct TreeNode*));
        sizes[i] = 0;

        for (int j = 1; j <= i; j++) {
            struct TreeNode** leftTrees = dp[j - 1];
            struct TreeNode** rightTrees = dp[i - j];
            int leftSize = sizes[j - 1];
            int rightSize = sizes[i - j];

            for (int l = 0; l < leftSize; l++) {
                for (int r = 0; r < rightSize; r++) {
                    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
                    root->val = j;
                    root->left = leftTrees[l];
                    root->right = rightTrees[r];
                    dp[i][sizes[i]++] = root;
                }
            }
        }
    }

    *returnSize = sizes[n];
    free(sizes);
    return dp[n];
}