class Solution {
public:
    int sumRootToLeaf(TreeNode* root) {
        return dfs(root, 0);
    }

    int dfs(TreeNode* node, int currentSum) {
        if (!node) {
            return 0;
        }
        currentSum = (currentSum << 1) | node->val;
        if (!node->left && !node->right) {
            return currentSum;
        }
        return dfs(node->left, currentSum) + dfs(node->right, currentSum);
    }
};