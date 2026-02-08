class Solution {
public:
    int findSecondMinimumValue(TreeNode* root) {
        if (!root) return -1;
        long first = root->val, second = LONG_MAX;
        dfs(root, first, second);
        return second == LONG_MAX ? -1 : second;
    }

    void dfs(TreeNode* node, long first, long& second) {
        if (!node) return;
        if (node->val > first && node->val < second) {
            second = node->val;
        } else if (node->val == first) {
            dfs(node->left, first, second);
            dfs(node->right, first, second);
        }
    }
};