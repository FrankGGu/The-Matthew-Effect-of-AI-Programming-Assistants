class Solution {
public:
    TreeNode* subtreeWithAllDeepest(TreeNode* root) {
        return dfs(root).first;
    }

private:
    pair<TreeNode*, int> dfs(TreeNode* node) {
        if (!node) {
            return {nullptr, 0};
        }

        pair<TreeNode*, int> left = dfs(node->left);
        pair<TreeNode*, int> right = dfs(node->right);

        if (left.second > right.second) {
            return {left.first, left.second + 1};
        } else if (right.second > left.second) {
            return {right.first, right.second + 1};
        } else {
            return {node, left.second + 1};
        }
    }
};