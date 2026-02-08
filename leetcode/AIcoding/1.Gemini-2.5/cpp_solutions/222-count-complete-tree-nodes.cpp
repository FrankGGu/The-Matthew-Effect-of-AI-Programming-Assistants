class Solution {
public:
    int getHeight(TreeNode* node) {
        if (!node) {
            return -1; 
        }
        int h = 0;
        while (node->left) {
            h++;
            node = node->left;
        }
        return h;
    }

    int countNodes(TreeNode* root) {
        if (!root) {
            return 0;
        }

        int leftHeight = getHeight(root->left);
        int rightHeight = getHeight(root->right);

        if (leftHeight == rightHeight) {
            // If the leftmost path height of the left subtree is equal to the leftmost path height of the right subtree,
            // it means the left subtree is a perfect binary tree of height `leftHeight`.
            // The total number of nodes in (root + left subtree) is 2^(leftHeight + 1).
            // We then recursively count nodes in the right subtree.
            return (1 << (leftHeight + 1)) + countNodes(root->right);
        } else { // leftHeight > rightHeight
            // If the leftmost path height of the left subtree is greater than that of the right subtree,
            // it means the right subtree is a perfect binary tree of height `rightHeight`.
            // The total number of nodes in (root + right subtree) is 2^(rightHeight + 1).
            // We then recursively count nodes in the left subtree.
            return (1 << (rightHeight + 1)) + countNodes(root->left);
        }
    }
};