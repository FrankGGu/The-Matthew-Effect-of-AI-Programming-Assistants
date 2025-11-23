class Solution {
public:
    int sumEvenGrandparent(TreeNode* root) {
        return dfs(root, nullptr, nullptr);
    }

    int dfs(TreeNode* node, TreeNode* parent, TreeNode* grandparent) {
        if (!node) return 0;
        int sum = (grandparent && grandparent->val % 2 == 0) ? node->val : 0;
        sum += dfs(node->left, node, parent) + dfs(node->right, node, parent);
        return sum;
    }
};