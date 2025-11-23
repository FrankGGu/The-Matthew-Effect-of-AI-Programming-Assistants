class Solution {
public:
    string tree2str(TreeNode* root) {
        if (!root) return "";
        string res = to_string(root->val);
        if (root->left || root->right) {
            res += "(" + tree2str(root->left) + ")";
            if (root->right) {
                res += "(" + tree2str(root->right) + ")";
            }
        }
        return res;
    }
};