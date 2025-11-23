class Solution {
public:
    TreeNode* increasingBST(TreeNode* root) {
        TreeNode* dummy = new TreeNode(0);
        TreeNode* curr = dummy;
        inorder(root, curr);
        return dummy->right;
    }

private:
    void inorder(TreeNode* root, TreeNode*& curr) {
        if (!root) return;
        inorder(root->left, curr);
        curr->right = new TreeNode(root->val);
        curr = curr->right;
        inorder(root->right, curr);
    }
};