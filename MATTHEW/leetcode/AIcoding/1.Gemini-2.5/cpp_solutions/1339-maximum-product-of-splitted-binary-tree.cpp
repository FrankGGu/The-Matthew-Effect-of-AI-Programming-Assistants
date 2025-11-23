#include <algorithm> // Required for std::max

class Solution {
public:
    long long totalTreeSum;
    long long maxProductValue;
    long long MOD = 1000000007;

    void calculateTotalSum(TreeNode* node) {
        if (!node) {
            return;
        }
        totalTreeSum += node->val;
        calculateTotalSum(node->left);
        calculateTotalSum(node->right);
    }

    long long dfs(TreeNode* node) {
        if (!node) {
            return 0;
        }

        long long leftSubtreeSum = dfs(node->left);
        long long rightSubtreeSum = dfs(node->right);

        long long currentSubtreeSum = node->val + leftSubtreeSum + rightSubtreeSum;

        maxProductValue = std::max(maxProductValue, currentSubtreeSum * (totalTreeSum - currentSubtreeSum));

        return currentSubtreeSum;
    }

    int maxProduct(TreeNode* root) {
        totalTreeSum = 0;
        maxProductValue = 0;

        calculateTotalSum(root);
        dfs(root);

        return maxProductValue % MOD;
    }
};