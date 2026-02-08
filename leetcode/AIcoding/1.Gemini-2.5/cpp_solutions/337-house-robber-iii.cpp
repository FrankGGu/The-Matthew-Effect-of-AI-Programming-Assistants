class Solution {
public:
    std::pair<int, int> dfs(TreeNode* node) {
        if (!node) {
            return {0, 0};
        }

        std::pair<int, int> left_res = dfs(node->left);
        std::pair<int, int> right_res = dfs(node->right);

        int rob_current = node->val + left_res.second + right_res.second;

        int dont_rob_current = std::max(left_res.first, left_res.second) +
                               std::max(right_res.first, right_res.second);

        return {rob_current, dont_rob_current};
    }

    int rob(TreeNode* root) {
        std::pair<int, int> result = dfs(root);
        return std::max(result.first, result.second);
    }
};