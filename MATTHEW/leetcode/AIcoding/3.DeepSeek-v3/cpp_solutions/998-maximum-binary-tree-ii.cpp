class Solution {
public:
    TreeNode* insertIntoMaxTree(TreeNode* root, int val) {
        if (root == nullptr) {
            return new TreeNode(val);
        }
        if (val > root->val) {
            TreeNode* node = new TreeNode(val);
            node->left = root;
            return node;
        } else {
            root->right = insertIntoMaxTree(root->right, val);
            return root;
        }
    }
};