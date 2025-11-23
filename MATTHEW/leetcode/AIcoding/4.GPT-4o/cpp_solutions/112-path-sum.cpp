class Solution {
public:
    bool hasPathSum(TreeNode* root, int sum) {
        if (!root) return sum == 0;
        sum -= root->val;
        if (!root->left && !root->right) return sum == 0;
        return hasPathSum(root->left, sum) || hasPathSum(root->right, sum);
    }
};