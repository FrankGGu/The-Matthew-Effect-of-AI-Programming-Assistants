class Solution {
public:
    int sumNumbers(TreeNode* root) {
        return sumNumbersHelper(root, 0);
    }

    int sumNumbersHelper(TreeNode* root, int currentSum) {
        if (!root) {
            return 0;
        }

        currentSum = currentSum * 10 + root->val;

        if (!root->left && !root->right) {
            return currentSum;
        }

        return sumNumbersHelper(root->left, currentSum) + sumNumbersHelper(root->right, currentSum);
    }
};