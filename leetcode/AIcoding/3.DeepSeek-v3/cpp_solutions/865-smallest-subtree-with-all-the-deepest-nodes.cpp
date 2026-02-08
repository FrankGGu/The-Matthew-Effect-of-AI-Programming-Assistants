class Solution {
public:
    TreeNode* subtreeWithAllDeepest(TreeNode* root) {
        return dfs(root).second;
    }

    pair<int, TreeNode*> dfs(TreeNode* node) {
        if (!node) return {0, nullptr};
        auto left = dfs(node->left);
        auto right = dfs(node->right);
        int d1 = left.first, d2 = right.first;
        if (d1 == d2) return {d1 + 1, node};
        if (d1 > d2) return {d1 + 1, left.second};
        return {d2 + 1, right.second};
    }
};