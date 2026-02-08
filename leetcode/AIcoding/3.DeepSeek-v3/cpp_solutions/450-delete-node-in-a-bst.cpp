class Solution {
public:
    TreeNode* deleteNode(TreeNode* root, int key) {
        if (!root) return nullptr;
        if (root->val > key) {
            root->left = deleteNode(root->left, key);
        } else if (root->val < key) {
            root->right = deleteNode(root->right, key);
        } else {
            if (!root->left || !root->right) {
                TreeNode* temp = root->left ? root->left : root->right;
                delete root;
                return temp;
            } else {
                TreeNode* temp = root->right;
                while (temp->left) temp = temp->left;
                root->val = temp->val;
                root->right = deleteNode(root->right, temp->val);
            }
        }
        return root;
    }
};