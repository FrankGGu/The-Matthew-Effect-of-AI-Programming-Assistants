/**
 * Definition for a binary tree node.
 * struct TreeNode {
 *     int val;
 *     struct TreeNode *left;
 *     struct TreeNode *right;
 * };
 */

int maxAncestorDiff(struct TreeNode* root) {
    if (!root) return 0;

    int maxDiff = 0;

    void dfs(struct TreeNode* node, int minVal, int maxVal) {
        if (!node) return;

        int currentDiff1 = abs(node->val - minVal);
        int currentDiff2 = abs(node->val - maxVal);
        if (currentDiff1 > maxDiff) maxDiff = currentDiff1;
        if (currentDiff2 > maxDiff) maxDiff = currentDiff2;

        int newMin = (node->val < minVal) ? node->val : minVal;
        int newMax = (node->val > maxVal) ? node->val : maxVal;

        dfs(node->left, newMin, newMax);
        dfs(node->right, newMin, newMax);
    }

    dfs(root, root->val, root->val);
    return maxDiff;
}