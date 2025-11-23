/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

typedef struct {
    int dp[2];
} Result;

Result dfs(struct TreeNode* root) {
    if (root == NULL) {
        Result res = {{0, 0}};
        return res;
    }

    Result left = dfs(root->left);
    Result right = dfs(root->right);

    Result res;
    res.dp[0] = fmax(left.dp[0], left.dp[1]) + fmax(right.dp[0], right.dp[1]);
    res.dp[1] = root->val + left.dp[0] + right.dp[0];

    return res;
}

int maxValue(struct TreeNode* root, int k) {
    Result res = dfs(root);
    return fmax(res.dp[0], res.dp[1]);
}