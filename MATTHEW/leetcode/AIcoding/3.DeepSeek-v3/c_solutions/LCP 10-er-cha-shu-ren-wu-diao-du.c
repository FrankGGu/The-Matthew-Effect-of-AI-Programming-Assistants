/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

typedef struct {
    double total;
    double max;
} Result;

Result dfs(struct TreeNode* root) {
    if (root == NULL) {
        return (Result){0.0, 0.0};
    }

    Result left = dfs(root->left);
    Result right = dfs(root->right);

    double total = left.total + right.total + root->val;
    double max_child = fmax(left.max, right.max);
    double max_time = fmax(max_child, (left.total + right.total) / 2.0) + root->val;

    return (Result){total, max_time};
}

double minimalExecTime(struct TreeNode* root) {
    Result res = dfs(root);
    return res.max;
}