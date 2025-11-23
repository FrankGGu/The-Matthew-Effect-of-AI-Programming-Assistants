class Solution {
public:
    int maxAncestorDiff(TreeNode* root) {
        if (!root) return 0;
        return helper(root, root->val, root->val);
    }

    int helper(TreeNode* node, int min_val, int max_val) {
        if (!node) return max_val - min_val;
        min_val = min(min_val, node->val);
        max_val = max(max_val, node->val);
        int left = helper(node->left, min_val, max_val);
        int right = helper(node->right, min_val, max_val);
        return max(left, right);
    }
};