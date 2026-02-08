class Solution {
public:
    bool isUnivalTree(TreeNode* root) {
        if (!root) return true;
        return isUnivalTreeHelper(root, root->val);
    }

    bool isUnivalTreeHelper(TreeNode* node, int value) {
        if (!node) return true;
        if (node->val != value) return false;
        return isUnivalTreeHelper(node->left, value) && isUnivalTreeHelper(node->right, value);
    }
};