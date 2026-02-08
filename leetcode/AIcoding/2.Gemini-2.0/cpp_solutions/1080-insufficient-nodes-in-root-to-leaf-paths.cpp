class Solution {
public:
    TreeNode* sufficientSubset(TreeNode* root, int limit) {
        function<bool(TreeNode*, int)> dfs = [&](TreeNode* node, int currentSum) {
            if (!node) return false;
            if (!node->left && !node->right) {
                return currentSum + node->val >= limit;
            }

            bool leftSufficient = dfs(node->left, currentSum + node->val);
            bool rightSufficient = dfs(node->right, currentSum + node->val);

            if (!leftSufficient) node->left = nullptr;
            if (!rightSufficient) node->right = nullptr;

            return leftSufficient || rightSufficient;
        };

        if (!dfs(root, 0)) return nullptr;
        return root;
    }
};