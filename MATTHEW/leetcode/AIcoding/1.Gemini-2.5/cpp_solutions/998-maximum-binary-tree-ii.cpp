class Solution {
public:
    TreeNode* insertIntoMaxTree(TreeNode* root, int val) {
        if (!root) {
            return new TreeNode(val);
        }

        if (val > root->val) {
            TreeNode* newNode = new TreeNode(val);
            newNode->left = root;
            return newNode;
        } else {
            root->right = insertIntoMaxTree(root->right, val);
            return root;
        }
    }
};