class Solution {
public:
    std::string tree2str(TreeNode* root) {
        if (!root) {
            return "";
        }

        std::string s = std::to_string(root->val);

        if (!root->left && !root->right) {
            return s;
        }

        if (root->left) {
            s += "(" + tree2str(root->left) + ")";
        } else {
            s += "()";
        }

        if (root->right) {
            s += "(" + tree2str(root->right) + ")";
        }

        return s;
    }
};