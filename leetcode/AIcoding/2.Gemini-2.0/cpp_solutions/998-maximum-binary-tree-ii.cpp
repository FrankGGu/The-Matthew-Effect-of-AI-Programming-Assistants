class Solution {
public:
    TreeNode* insertIntoMaxTree(TreeNode* root, int val) {
        TreeNode* newNode = new TreeNode(val);
        if (!root) return newNode;

        if (val > root->val) {
            newNode->left = root;
            return newNode;
        }

        TreeNode* curr = root;
        while (curr->right && curr->right->val > val) {
            curr = curr->right;
        }

        newNode->left = curr->right;
        curr->right = newNode;

        return root;
    }
};