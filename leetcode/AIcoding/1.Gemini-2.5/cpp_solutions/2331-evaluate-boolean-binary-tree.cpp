class Solution {
public:
    bool evaluateTree(TreeNode* root) {
        if (root->val == 0) {
            return false;
        }
        if (root->val == 1) {
            return true;
        }

        bool left_result = evaluateTree(root->left);
        bool right_result = evaluateTree(root->right);

        if (root->val == 2) { // OR operation
            return left_result || right_result;
        } else { // root->val == 3, AND operation
            return left_result && right_result;
        }
    }
};