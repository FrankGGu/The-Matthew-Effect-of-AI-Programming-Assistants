class Solution {
public:
    int goodNodes(TreeNode* root) {
        if (!root) return 0;
        int count = 0;
        dfs(root, root->val, count);
        return count;
    }

    void dfs(TreeNode* node, int max_val, int& count) {
        if (!node) return;
        if (node->val >= max_val) {
            count++;
            max_val = node->val;
        }
        dfs(node->left, max_val, count);
        dfs(node->right, max_val, count);
    }
};