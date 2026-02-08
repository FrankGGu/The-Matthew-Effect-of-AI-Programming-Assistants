class Solution {
public:
    int countValidPaths(TreeNode* root, int sum) {
        return dfs(root, sum, 0);
    }

private:
    int dfs(TreeNode* node, int target, int currentSum) {
        if (!node) return 0;
        currentSum += node->val;
        int count = (currentSum == target) ? 1 : 0;
        count += dfs(node->left, target, currentSum);
        count += dfs(node->right, target, currentSum);
        return count;
    }
};