class Solution {
public:
    int getMinimumDifference(TreeNode* root) {
        int min_diff = INT_MAX;
        TreeNode* prev = nullptr;
        inorder(root, prev, min_diff);
        return min_diff;
    }

private:
    void inorder(TreeNode* node, TreeNode*& prev, int& min_diff) {
        if (!node) return;
        inorder(node->left, prev, min_diff);
        if (prev) {
            min_diff = min(min_diff, node->val - prev->val);
        }
        prev = node;
        inorder(node->right, prev, min_diff);
    }
};