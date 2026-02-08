class Solution {
public:
    int maxAncestorDiff(TreeNode* root) {
        if (!root) {
            return 0;
        }
        return helper(root, root->val, root->val);
    }

private:
    int helper(TreeNode* node, int min_val, int max_val) {
        if (!node) {
            return max_val - min_val;
        }

        min_val = std::min(min_val, node->val);
        max_val = std::max(max_val, node->val);

        int left_diff = helper(node->left, min_val, max_val);
        int right_diff = helper(node->right, min_val, max_val);

        return std::max(left_diff, right_diff);
    }
};