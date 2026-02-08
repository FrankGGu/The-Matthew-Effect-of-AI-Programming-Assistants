class Solution {
public:
    int maxPathSum(TreeNode* root) {
        int maxSum = INT_MIN;
        maxPathHelper(root, maxSum);
        return maxSum;
    }

    int maxPathHelper(TreeNode* node, int& maxSum) {
        if (!node) return 0;
        int left = max(maxPathHelper(node->left, maxSum), 0);
        int right = max(maxPathHelper(node->right, maxSum), 0);
        maxSum = max(maxSum, node->val + left + right);
        return node->val + max(left, right);
    }
};