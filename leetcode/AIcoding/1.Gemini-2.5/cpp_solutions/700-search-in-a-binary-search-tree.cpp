class Solution {
public:
    TreeNode* searchBST(TreeNode* root, int val) {
        TreeNode* current = root;
        while (current != nullptr) {
            if (current->val == val) {
                return current;
            } else if (val < current->val) {
                current = current->left;
            } else {
                current = current->right;
            }
        }
        return nullptr;
    }
};