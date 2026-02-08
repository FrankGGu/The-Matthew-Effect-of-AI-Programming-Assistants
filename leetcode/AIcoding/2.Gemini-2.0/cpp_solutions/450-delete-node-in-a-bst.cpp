class Solution {
public:
    TreeNode* deleteNode(TreeNode* root, int key) {
        if (!root) return nullptr;

        if (key < root->val) {
            root->left = deleteNode(root->left, key);
        } else if (key > root->val) {
            root->right = deleteNode(root->right, key);
        } else {
            if (!root->left) {
                return root->right;
            } else if (!root->right) {
                return root->left;
            } else {
                TreeNode* minNode = findMin(root->right);
                root->val = minNode->val;
                root->right = deleteNode(root->right, minNode->val);
            }
        }
        return root;
    }

private:
    TreeNode* findMin(TreeNode* node) {
        while (node->left) {
            node = node->left;
        }
        return node;
    }
};