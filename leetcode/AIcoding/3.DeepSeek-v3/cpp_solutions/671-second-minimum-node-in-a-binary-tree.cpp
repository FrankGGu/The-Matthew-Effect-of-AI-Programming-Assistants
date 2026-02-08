class Solution {
public:
    int findSecondMinimumValue(TreeNode* root) {
        if (!root) return -1;
        long first = root->val;
        long second = LONG_MAX;
        helper(root, first, second);
        return second == LONG_MAX ? -1 : second;
    }

    void helper(TreeNode* node, long first, long& second) {
        if (!node) return;
        if (node->val > first && node->val < second) {
            second = node->val;
        }
        helper(node->left, first, second);
        helper(node->right, first, second);
    }
};