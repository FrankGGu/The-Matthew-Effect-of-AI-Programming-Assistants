class Solution {
public:
    TreeNode* lowestCommonAncestor(TreeNode* root, TreeNode* p, TreeNode* q) {
        if (!root || !p || !q) {
            return nullptr;
        }

        TreeNode* current = root;
        while (current) {
            if (p->val < current->val && q->val < current->val) {
                current = current->left;
            } else if (p->val > current->val && q->val > current->val) {
                current = current->right;
            } else {
                // This is the split point, or one of the nodes is the current node.
                // In a BST, this means current is the LCA.
                return current;
            }
        }
        return nullptr; // Should not reach here if p and q are guaranteed to be in the tree
    }
};