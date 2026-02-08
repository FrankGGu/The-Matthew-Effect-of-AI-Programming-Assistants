class Solution {
public:
    int countNodesInRange(TreeNode* node, int low, int high) {
        if (!node) {
            return 0;
        }
        if (node->val > high) {
            return countNodesInRange(node->left, low, high);
        }
        if (node->val < low) {
            return countNodesInRange(node->right, low, high);
        }
        return 1 + countNodesInRange(node->left, low, high) + countNodesInRange(node->right, low, high);
    }

    int bstColoring(TreeNode* root, int low, int high) {
        int k = countNodesInRange(root, low, high);
        return (k + 1) / 2;
    }
};