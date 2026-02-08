class Solution {
public:
    int findSecondMinimumValue(TreeNode* root) {
        if (!root) return -1;
        long long first = root->val;
        long long second = LLONG_MAX;

        function<void(TreeNode*)> dfs = [&](TreeNode* node) {
            if (!node) return;
            if (node->val > first && node->val < second) {
                second = node->val;
            } else if (node->val == first) {
                dfs(node->left);
                dfs(node->right);
            }
        };

        dfs(root);

        return (second == LLONG_MAX) ? -1 : second;
    }
};