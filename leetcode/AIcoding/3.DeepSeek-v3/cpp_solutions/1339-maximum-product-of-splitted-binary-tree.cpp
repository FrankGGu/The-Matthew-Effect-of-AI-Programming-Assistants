class Solution {
public:
    long long totalSum = 0;
    long long maxProduct = 0;
    const int MOD = 1e9 + 7;

    int calculateTotalSum(TreeNode* root) {
        if (!root) return 0;
        int leftSum = calculateTotalSum(root->left);
        int rightSum = calculateTotalSum(root->right);
        return root->val + leftSum + rightSum;
    }

    int findMaxProduct(TreeNode* root) {
        if (!root) return 0;
        int leftSum = findMaxProduct(root->left);
        int rightSum = findMaxProduct(root->right);
        long long subtreeSum = root->val + leftSum + rightSum;
        maxProduct = max(maxProduct, subtreeSum * (totalSum - subtreeSum));
        return subtreeSum;
    }

    int maxProduct(TreeNode* root) {
        totalSum = calculateTotalSum(root);
        findMaxProduct(root);
        return maxProduct % MOD;
    }
};