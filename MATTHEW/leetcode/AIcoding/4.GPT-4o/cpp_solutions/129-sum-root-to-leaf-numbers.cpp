class Solution {
public:
    int sumNumbers(TreeNode* root) {
        return sumNumbersHelper(root, 0);
    }

    int sumNumbersHelper(TreeNode* node, int currentSum) {
        if (!node) return 0;
        currentSum = currentSum * 10 + node->val;
        if (!node->left && !node->right) return currentSum;
        return sumNumbersHelper(node->left, currentSum) + sumNumbersHelper(node->right, currentSum);
    }
};