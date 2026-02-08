class Solution {
public:
    long long totalSum = 0;
    long long maxProduct = 0;
    const int MOD = 1e9 + 7;

    long long calculateSum(TreeNode* root) {
        if (!root) return 0;
        long long leftSum = calculateSum(root->left);
        long long rightSum = calculateSum(root->right);
        return root->val + leftSum + rightSum;
    }

    long long findMaxProductHelper(TreeNode* root) {
        if (!root) return 0;

        long long leftSum = findMaxProductHelper(root->left);
        long long rightSum = findMaxProductHelper(root->right);

        long long currentSum = root->val + leftSum + rightSum;

        maxProduct = max(maxProduct, currentSum * (totalSum - currentSum));

        return currentSum;
    }

    int maxProductAfterSplittingTree(TreeNode* root) {
        totalSum = calculateSum(root);
        findMaxProductHelper(root);
        return maxProduct % MOD;
    }
};