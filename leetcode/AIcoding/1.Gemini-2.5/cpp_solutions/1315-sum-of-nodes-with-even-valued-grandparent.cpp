class Solution {
public:
    int sumEvenGrandparent(TreeNode* root) {
        int totalSum = 0;
        dfs(root, nullptr, nullptr, totalSum);
        return totalSum;
    }

private:
    void dfs(TreeNode* node, TreeNode* parent, TreeNode* grandparent, int& sum) {
        if (!node) {
            return;
        }

        if (grandparent && (grandparent->val % 2 == 0)) {
            sum += node->val;
        }

        dfs(node->left, node, parent, sum);
        dfs(node->right, node, parent, sum);
    }
};