class Solution {
public:
    int moves = 0;

    int distribute(TreeNode* node) {
        if (!node) return 0;
        int left = distribute(node->left);
        int right = distribute(node->right);
        moves += abs(left) + abs(right);
        return node->val + left + right - 1;
    }

    int distributeCoins(TreeNode* root) {
        distribute(root);
        return moves;
    }
};