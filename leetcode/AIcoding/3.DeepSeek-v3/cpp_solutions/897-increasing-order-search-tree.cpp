class Solution {
public:
    TreeNode* increasingBST(TreeNode* root) {
        TreeNode* dummy = new TreeNode(0);
        TreeNode* curr = dummy;
        inorder(root, curr);
        return dummy->right;
    }

    void inorder(TreeNode* node, TreeNode*& curr) {
        if (!node) return;
        inorder(node->left, curr);
        node->left = nullptr;
        curr->right = node;
        curr = node;
        inorder(node->right, curr);
    }
};