struct TreeNode** allPossibleFBT(int n, int* returnSize) {
    if (n % 2 == 0) {
        *returnSize = 0;
        return NULL;
    }

    struct TreeNode*** dp = (struct TreeNode***)malloc((n + 1) * sizeof(struct TreeNode**));
    int* sizes = (int*)malloc((n + 1) * sizeof(int));

    dp[1] = (struct TreeNode**)malloc(sizeof(struct TreeNode*));
    dp[1][0] = (struct TreeNode*)malloc(sizeof(struct TreeNode));
    dp[1][0]->val = 0;
    dp[1][0]->left = NULL;
    dp[1][0]->right = NULL;
    sizes[1] = 1;

    for (int i = 3; i <= n; i += 2) {
        dp[i] = (struct TreeNode**)malloc(0);
        sizes[i] = 0;
        for (int j = 1; j < i; j += 2) {
            int leftSize = sizes[j];
            int rightSize = sizes[i - 1 - j];
            for (int l = 0; l < leftSize; l++) {
                for (int r = 0; r < rightSize; r++) {
                    struct TreeNode* root = (struct TreeNode*)malloc(sizeof(struct TreeNode));
                    root->val = 0;
                    root->left = dp[j][l];
                    root->right = dp[i - 1 - j][r];
                    dp[i] = (struct TreeNode**)realloc(dp[i], (sizes[i] + 1) * sizeof(struct TreeNode*));
                    dp[i][sizes[i]] = root;
                    sizes[i]++;
                }
            }
        }
    }

    *returnSize = sizes[n];
    free(sizes);
    return dp[n];
}