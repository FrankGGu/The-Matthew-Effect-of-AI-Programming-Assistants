#include <algorithm> // Required for std::min

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode() : val(0), left(nullptr), right(nullptr) {}
    TreeNode(int x) : val(x), left(nullptr), right(nullptr) {}
    TreeNode(int x, TreeNode *left, TreeNode *right) : val(x), left(left), right(right) {}
};

class Solution {
public:
    int minDepth(TreeNode* root) {
        if (root == nullptr) {
            return 0;
        }

        // If it's a leaf node (no children)
        if (root->left == nullptr && root->right == nullptr) {
            return 1;
        }

        // If only the left child exists, the minimum depth must come from the left subtree
        if (root->left != nullptr && root->right == nullptr) {
            return 1 + minDepth(root->left);
        }

        // If only the right child exists, the minimum depth must come from the right subtree
        if (root->left == nullptr && root->right != nullptr) {
            return 1 + minDepth(root->right);
        }

        // If both children exist, the minimum depth is 1 plus the minimum of the depths of the two subtrees
        return 1 + std::min(minDepth(root->left), minDepth(root->right));
    }
};