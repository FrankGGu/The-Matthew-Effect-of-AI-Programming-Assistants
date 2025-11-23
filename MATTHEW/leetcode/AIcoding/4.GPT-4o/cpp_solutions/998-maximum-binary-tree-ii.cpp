class Solution {
public:
    TreeNode* insertIntoMaxTree(TreeNode* root, int val) {
        TreeNode* newNode = new TreeNode(val);
        if (!root || val > root->val) {
            newNode->left = root;
            return newNode;
        }
        TreeNode* current = root;
        while (current->right && current->right->val > val) {
            current = current->right;
        }
        newNode->left = current->right;
        current->right = newNode;
        return root;
    }
};