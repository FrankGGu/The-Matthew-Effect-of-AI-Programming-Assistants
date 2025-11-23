class Solution {
private:
    int totalSum;

    void dfs(TreeNode* node, int currentNumber) {
        if (node == nullptr) {
            return;
        }

        currentNumber = currentNumber * 10 + node->val;

        if (node->left == nullptr && node->right == nullptr) {
            totalSum += currentNumber;
            return;
        }

        dfs(node->left, currentNumber);
        dfs(node->right, currentNumber);
    }

public:
    int sumNumbers(TreeNode* root) {
        totalSum = 0;
        dfs(root, 0);
        return totalSum;
    }
};