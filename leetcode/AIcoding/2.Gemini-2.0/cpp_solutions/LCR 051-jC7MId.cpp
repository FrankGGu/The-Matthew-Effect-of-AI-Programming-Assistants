class Solution {
public:
    int maxPathSum(TreeNode* root) {
        int maxSum = INT_MIN;
        function<int(TreeNode*)> dfs = [&](TreeNode* node) {
            if (!node) return 0;
            int leftSum = max(0, dfs(node->left));
            int rightSum = max(0, dfs(node->right));
            maxSum = max(maxSum, node->val + leftSum + rightSum);
            return node->val + max(leftSum, rightSum);
        };
        dfs(root);
        return maxSum;
    }
};