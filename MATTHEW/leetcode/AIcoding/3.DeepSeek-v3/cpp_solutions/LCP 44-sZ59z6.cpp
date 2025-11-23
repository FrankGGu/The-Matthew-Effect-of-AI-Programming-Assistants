class Solution {
public:
    int numColor(TreeNode* root) {
        unordered_set<int> colors;
        traverse(root, colors);
        return colors.size();
    }

    void traverse(TreeNode* node, unordered_set<int>& colors) {
        if (!node) return;
        colors.insert(node->val);
        traverse(node->left, colors);
        traverse(node->right, colors);
    }
};