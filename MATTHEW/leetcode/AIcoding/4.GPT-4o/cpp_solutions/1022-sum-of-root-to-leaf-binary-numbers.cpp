class TreeNode {
public:
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    int sumNumbers(TreeNode* root) {
        return sumHelper(root, 0);
    }

    int sumHelper(TreeNode* node, int currentSum) {
        if (!node) return 0;
        currentSum = (currentSum << 1) | node->val;
        if (!node->left && !node->right) return currentSum;
        return sumHelper(node->left, currentSum) + sumHelper(node->right, currentSum);
    }
};