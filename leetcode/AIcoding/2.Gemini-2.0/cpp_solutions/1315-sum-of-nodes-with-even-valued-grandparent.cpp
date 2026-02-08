class Solution {
public:
    int sumEvenGrandparent(TreeNode* root) {
        int sum = 0;
        dfs(root, nullptr, nullptr, sum);
        return sum;
    }

    void dfs(TreeNode* node, TreeNode* parent, TreeNode* grandparent, int& sum) {
        if (!node) return;

        if (grandparent && grandparent->val % 2 == 0) {
            sum += node->val;
        }

        dfs(node->left, node, parent, sum);
        dfs(node->right, node, parent, sum);
    }
};