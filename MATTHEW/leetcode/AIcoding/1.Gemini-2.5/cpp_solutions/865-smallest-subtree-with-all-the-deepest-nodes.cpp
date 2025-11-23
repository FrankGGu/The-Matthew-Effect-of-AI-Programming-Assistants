class Solution {
public:
    TreeNode* subtreeWithAllDeepest(TreeNode* root) {
        return dfs(root).second;
    }

private:
    std::pair<int, TreeNode*> dfs(TreeNode* node) {
        if (!node) {
            return {0, nullptr};
        }

        auto left_res = dfs(node->left);
        auto right_res = dfs(node->right);

        int left_depth = left_res.first;
        int right_depth = right_res.first;

        if (left_depth > right_depth) {
            return {left_depth + 1, left_res.second};
        }
        if (right_depth > left_depth) {
            return {right_depth + 1, right_res.second};
        }

        return {left_depth + 1, node};
    }
};