class Solution {
public:
    TreeNode* decorateTree(TreeNode* root) {
        if (!root) {
            return nullptr;
        }

        decorateTree(root->left);
        decorateTree(root->right);

        int left_val = root->left ? root->left->val : 0;
        int right_val = root->right ? root->right->val : 0;

        root->val = root->val + left_val + right_val;

        return root;
    }
};