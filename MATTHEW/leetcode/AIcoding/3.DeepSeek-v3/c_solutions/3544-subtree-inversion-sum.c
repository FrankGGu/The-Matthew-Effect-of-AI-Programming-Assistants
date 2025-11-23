/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

long long dfs(struct TreeNode* root, long long* sum) {
    if (root == NULL) return 0;

    long long left = dfs(root->left, sum);
    long long right = dfs(root->right, sum);

    long long total = left + right + root->val;
    *sum += total;

    return total;
}

long long dfsInvert(struct TreeNode* root, long long* sum) {
    if (root == NULL) return 0;

    long long left = dfsInvert(root->left, sum);
    long long right = dfsInvert(root->right, sum);

    long long original = left + right + root->val;

    struct TreeNode* temp = root->left;
    root->left = root->right;
    root->right = temp;

    long long newLeft = dfs(root->left, sum);
    long long newRight = dfs(root->right, sum);

    long long inverted = newLeft + newRight + root->val;
    *sum += inverted;

    return original;
}

long long invertedSum(struct TreeNode* root) {
    long long sum = 0;
    dfsInvert(root, &sum);
    return sum;
}