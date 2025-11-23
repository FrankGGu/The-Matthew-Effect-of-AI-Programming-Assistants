class Solution {
public:
    bool evaluateTree(TreeNode* root) {
        if (root->val < 2) {
            return root->val == 1;
        }

        bool left_val = evaluateTree(root->left);
        bool right_val = evaluateTree(root->right);

        if (root->val == 2) {
            return left_val || right_val;
        } else {
            return left_val && right_val;
        }
    }
};