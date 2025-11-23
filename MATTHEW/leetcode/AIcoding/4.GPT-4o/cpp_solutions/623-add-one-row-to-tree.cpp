class Solution {
public:
    TreeNode* addOneRow(TreeNode* root, int val, int depth) {
        if (depth == 1) {
            TreeNode* newRoot = new TreeNode(val);
            newRoot->left = root;
            return newRoot;
        }
        addRow(root, val, depth, 1);
        return root;
    }

    void addRow(TreeNode* node, int val, int depth, int currentDepth) {
        if (!node) return;
        if (currentDepth == depth - 1) {
            TreeNode* newLeft = new TreeNode(val);
            TreeNode* newRight = new TreeNode(val);
            newLeft->left = node->left;
            newRight->right = node->right;
            node->left = newLeft;
            node->right = newRight;
        } else {
            addRow(node->left, val, depth, currentDepth + 1);
            addRow(node->right, val, depth, currentDepth + 1);
        }
    }
};