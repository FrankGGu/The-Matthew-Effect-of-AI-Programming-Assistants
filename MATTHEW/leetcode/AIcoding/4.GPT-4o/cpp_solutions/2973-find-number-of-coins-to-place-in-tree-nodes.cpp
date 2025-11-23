class Solution {
public:
    int distributeCoins(TreeNode* root) {
        int moves = 0;
        dfs(root, moves);
        return moves;
    }

    int dfs(TreeNode* node, int& moves) {
        if (!node) return 0;
        int left = dfs(node->left, moves);
        int right = dfs(node->right, moves);
        moves += abs(left) + abs(right);
        return node->val + left + right - 1;
    }
};