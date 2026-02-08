class Solution {
public:
    bool isBalanced(TreeNode* root) {
        return checkHeight(root) != -1;
    }

private:
    int checkHeight(TreeNode* node) {
        if (!node) return 0;

        int left = checkHeight(node->left);
        if (left == -1) return -1;

        int right = checkHeight(node->right);
        if (right == -1) return -1;

        if (abs(left - right) > 1) return -1;
        return max(left, right) + 1;
    }
};