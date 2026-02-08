class Solution {
public:
    TreeNode* lcaDeepestLeaves(TreeNode* root) {
        int maxDepth = maxDepthOfTree(root);
        return lcaHelper(root, 1, maxDepth);
    }

private:
    int maxDepthOfTree(TreeNode* node) {
        if (!node) return 0;
        return 1 + max(maxDepthOfTree(node->left), maxDepthOfTree(node->right));
    }

    TreeNode* lcaHelper(TreeNode* node, int depth, int maxDepth) {
        if (!node) return nullptr;
        if (depth == maxDepth) return node;

        TreeNode* left = lcaHelper(node->left, depth + 1, maxDepth);
        TreeNode* right = lcaHelper(node->right, depth + 1, maxDepth);

        if (left && right) return node;
        return left ? left : right;
    }
};