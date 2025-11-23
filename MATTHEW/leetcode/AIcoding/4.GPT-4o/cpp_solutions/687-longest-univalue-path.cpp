class Solution {
public:
    int longestUnivaluePath(TreeNode* root) {
        int maxLength = 0;
        dfs(root, maxLength);
        return maxLength;
    }

    int dfs(TreeNode* node, int& maxLength) {
        if (!node) return 0;
        int leftLength = dfs(node->left, maxLength);
        int rightLength = dfs(node->right, maxLength);

        int leftPath = 0, rightPath = 0;
        if (node->left && node->left->val == node->val) {
            leftPath = leftLength + 1;
        }
        if (node->right && node->right->val == node->val) {
            rightPath = rightLength + 1;
        }

        maxLength = max(maxLength, leftPath + rightPath);
        return max(leftPath, rightPath);
    }
};