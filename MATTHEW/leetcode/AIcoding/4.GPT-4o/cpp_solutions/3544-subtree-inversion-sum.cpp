class Solution {
public:
    int subtreeInversionSum(TreeNode* root) {
        if (!root) return 0;
        return root->val + subtreeInversionSum(root->left) + subtreeInversionSum(root->right);
    }
};