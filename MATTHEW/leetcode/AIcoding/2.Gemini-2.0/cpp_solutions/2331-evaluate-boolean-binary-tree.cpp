class Solution {
public:
    bool evaluateTree(TreeNode* root) {
        if (root->left == nullptr && root->right == nullptr) {
            return root->val == 1;
        }

        bool leftVal = evaluateTree(root->left);
        bool rightVal = evaluateTree(root->right);

        if (root->val == 2) {
            return leftVal || rightVal;
        } else {
            return leftVal && rightVal;
        }
    }
};