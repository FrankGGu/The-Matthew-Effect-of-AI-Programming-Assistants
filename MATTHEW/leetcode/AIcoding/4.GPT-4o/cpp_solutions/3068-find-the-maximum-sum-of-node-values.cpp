class Solution {
public:
    int maxSum(TreeNode* root) {
        int max_sum = 0;
        dfs(root, max_sum);
        return max_sum;
    }

    int dfs(TreeNode* node, int& max_sum) {
        if (!node) return 0;
        int left = max(0, dfs(node->left, max_sum));
        int right = max(0, dfs(node->right, max_sum));
        max_sum = max(max_sum, left + right + node->val);
        return max(left, right) + node->val;
    }
};