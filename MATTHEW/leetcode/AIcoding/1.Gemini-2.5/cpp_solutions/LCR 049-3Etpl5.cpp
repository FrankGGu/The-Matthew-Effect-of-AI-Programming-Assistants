class Solution {
public:
    int sumNumbers(TreeNode* root) {
        return dfs(root, 0);
    }

private:
    int dfs(TreeNode* node, int current_sum) {
        if (!node) {
            return 0;
        }

        current_sum = current_sum * 10 + node->val;

        if (!node->left && !node->right) { // Leaf node
            return current_sum;
        }

        return dfs(node->left, current_sum) + dfs(node->right, current_sum);
    }
};