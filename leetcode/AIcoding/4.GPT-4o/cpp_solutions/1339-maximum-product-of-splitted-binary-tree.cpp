class Solution {
public:
    long long maxProduct = 0;
    long long totalSum = 0;

    int dfs(TreeNode* root) {
        if (!root) return 0;
        int leftSum = dfs(root->left);
        int rightSum = dfs(root->right);
        totalSum += root->val;
        long long currentSum = leftSum + rightSum + root->val;
        maxProduct = max(maxProduct, currentSum * (totalSum - currentSum));
        return currentSum;
    }

    int maxProduct(TreeNode* root) {
        dfs(root);
        return maxProduct % 1000000007;
    }
};