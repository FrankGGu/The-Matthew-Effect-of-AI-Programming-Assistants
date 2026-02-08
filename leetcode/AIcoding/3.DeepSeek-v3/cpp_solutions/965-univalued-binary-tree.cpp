class Solution {
public:
    bool isUnivalTree(TreeNode* root) {
        if (!root) return true;
        int value = root->val;
        return helper(root, value);
    }

    bool helper(TreeNode* node, int value) {
        if (!node) return true;
        if (node->val != value) return false;
        return helper(node->left, value) && helper(node->right, value);
    }
};