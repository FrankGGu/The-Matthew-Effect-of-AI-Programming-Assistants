class Solution {
public:
    int minDiffInBST(TreeNode* root) {
        int min_diff = INT_MAX;
        TreeNode* prev = nullptr;
        inorder(root, prev, min_diff);
        return min_diff;
    }

private:
    void inorder(TreeNode* root, TreeNode*& prev, int& min_diff) {
        if (!root) return;

        inorder(root->left, prev, min_diff);

        if (prev) {
            min_diff = min(min_diff, root->val - prev->val);
        }
        prev = root;

        inorder(root->right, prev, min_diff);
    }
};