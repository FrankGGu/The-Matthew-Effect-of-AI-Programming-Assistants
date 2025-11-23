class Solution {
public:
    int minDiff = INT_MAX;
    TreeNode* prev = nullptr;

    void inorder(TreeNode* node) {
        if (!node) return;
        inorder(node->left);
        if (prev) {
            minDiff = min(minDiff, node->val - prev->val);
        }
        prev = node;
        inorder(node->right);
    }

    int getMinimumDifference(TreeNode* root) {
        inorder(root);
        return minDiff;
    }
};