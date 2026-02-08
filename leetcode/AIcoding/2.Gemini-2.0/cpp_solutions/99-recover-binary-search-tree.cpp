class Solution {
public:
    void recoverTree(TreeNode* root) {
        TreeNode *first = nullptr, *second = nullptr, *prev = nullptr;
        inorder(root, first, second, prev);
        swap(first->val, second->val);
    }

private:
    void inorder(TreeNode* root, TreeNode*& first, TreeNode*& second, TreeNode*& prev) {
        if (!root) return;

        inorder(root->left, first, second, prev);

        if (prev && root->val < prev->val) {
            if (!first) {
                first = prev;
                second = root;
            } else {
                second = root;
            }
        }
        prev = root;

        inorder(root->right, first, second, prev);
    }
};