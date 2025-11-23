class Solution {
public:
    TreeNode* lowestCommonAncestor(TreeNode* root, TreeNode* p, TreeNode* q) {
        if (root == nullptr || root == p || root == q) {
            return root;
        }

        TreeNode* left_lca = lowestCommonAncestor(root->left, p, q);
        TreeNode* right_lca = lowestCommonAncestor(root->right, p, q);

        if (left_lca != nullptr && right_lca != nullptr) {
            return root;
        } else if (left_lca != nullptr) {
            return left_lca;
        } else {
            return right_lca;
        }
    }
};