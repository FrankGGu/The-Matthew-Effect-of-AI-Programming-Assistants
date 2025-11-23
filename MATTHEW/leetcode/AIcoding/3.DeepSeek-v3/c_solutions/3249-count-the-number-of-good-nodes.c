/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

int goodNodes(struct TreeNode* root) {
    if (root == NULL) return 0;

    int count = 0;

    void dfs(struct TreeNode* node, int max_val) {
        if (node == NULL) return;

        if (node->val >= max_val) {
            count++;
            max_val = node->val;
        }

        dfs(node->left, max_val);
        dfs(node->right, max_val);
    }

    dfs(root, root->val);
    return count;
}