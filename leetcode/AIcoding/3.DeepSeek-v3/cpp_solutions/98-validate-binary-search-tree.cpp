class Solution {
public:
    bool isValidBST(TreeNode* root) {
        return helper(root, nullptr, nullptr);
    }

    bool helper(TreeNode* node, TreeNode* minNode, TreeNode* maxNode) {
        if (!node) return true;
        if ((minNode && node->val <= minNode->val) || (maxNode && node->val >= maxNode->val))
            return false;
        return helper(node->left, minNode, node) && helper(node->right, node, maxNode);
    }
};