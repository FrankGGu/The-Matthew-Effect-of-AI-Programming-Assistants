class Solution {
public:
    int minimalExecTime(TreeNode* root) {
        auto res = dfs(root);
        return res.first + res.second;
    }

private:
    pair<int, int> dfs(TreeNode* node) {
        if (!node) return {0, 0};
        auto left = dfs(node->left);
        auto right = dfs(node->right);
        int total = left.first + right.first;
        int parallel = min(left.second, right.second);
        int serial = max(left.second, right.second) - parallel;
        if (node->val > serial) {
            parallel += serial;
            serial = node->val;
        } else {
            parallel += node->val;
            serial -= node->val;
        }
        return {total + node->val, parallel + serial};
    }
};