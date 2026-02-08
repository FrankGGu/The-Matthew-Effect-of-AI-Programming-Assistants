class Solution {
public:
    int distributeCoins(TreeNode* root) {
        int moves = 0;
        helper(root, moves);
        return moves;
    }

    int helper(TreeNode* node, int& moves) {
        if (!node) return 0;
        int left = helper(node->left, moves);
        int right = helper(node->right, moves);
        moves += abs(left) + abs(right);
        return node->val + left + right - 1;
    }
};