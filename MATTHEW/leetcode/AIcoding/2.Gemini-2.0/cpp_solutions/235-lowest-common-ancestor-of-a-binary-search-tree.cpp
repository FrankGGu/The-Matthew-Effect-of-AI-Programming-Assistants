class Solution {
public:
    TreeNode* lowestCommonAncestor(TreeNode* root, TreeNode* p, TreeNode* q) {
        if (!root) return nullptr;

        if (p->val > q->val) {
            std::swap(p, q);
        }

        while (root) {
            if (root->val > q->val) {
                root = root->left;
            } else if (root->val < p->val) {
                root = root->right;
            } else {
                return root;
            }
        }
        return nullptr;
    }
};