class Solution {
public:
    std::vector<int> rightSideView(TreeNode* root) {
        std::vector<int> result;
        dfs(root, 0, result);
        return result;
    }

private:
    void dfs(TreeNode* node, int level, std::vector<int>& result) {
        if (!node) {
            return;
        }

        if (level == result.size()) {
            result.push_back(node->val);
        }

        dfs(node->right, level + 1, result);
        dfs(node->left, level + 1, result);
    }
};