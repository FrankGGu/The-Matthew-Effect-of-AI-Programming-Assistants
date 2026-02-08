class Solution {
public:
    int longestUnivaluePath(TreeNode* root) {
        int res = 0;
        helper(root, res);
        return res;
    }

private:
    int helper(TreeNode* node, int& res) {
        if (!node) return 0;
        int left = helper(node->left, res);
        int right = helper(node->right, res);
        int leftPath = (node->left && node->left->val == node->val) ? left + 1 : 0;
        int rightPath = (node->right && node->right->val == node->val) ? right + 1 : 0;
        res = max(res, leftPath + rightPath);
        return max(leftPath, rightPath);
    }
};