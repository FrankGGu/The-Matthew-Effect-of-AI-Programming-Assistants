class TreeNode {
public:
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    int diameterOfBinaryTree(TreeNode* root) {
        int diameter = 0;
        depth(root, diameter);
        return diameter;
    }

    int depth(TreeNode* node, int& diameter) {
        if (!node) return 0;
        int leftDepth = depth(node->left, diameter);
        int rightDepth = depth(node->right, diameter);
        diameter = max(diameter, leftDepth + rightDepth);
        return max(leftDepth, rightDepth) + 1;
    }
};