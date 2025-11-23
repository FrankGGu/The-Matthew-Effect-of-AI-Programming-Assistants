class Solution {
public:
    int sumRootToLeaf(TreeNode* root) {
        int sum = 0;
        dfs(root, 0, sum);
        return sum;
    }

private:
    void dfs(TreeNode* node, int current, int& sum) {
        if (!node) return;

        current = (current << 1) | node->val;

        if (!node->left && !node->right) {
            sum += current;
            return;
        }

        dfs(node->left, current, sum);
        dfs(node->right, current, sum);
    }
};