class Solution {
public:
    int moves = 0;

    int distributeCoinsHelper(TreeNode* root) {
        if (!root) return 0;

        int left = distributeCoinsHelper(root->left);
        int right = distributeCoinsHelper(root->right);

        moves += abs(left) + abs(right);

        return root->val + left + right - 1;
    }

    int distributeCoins(TreeNode* root) {
        distributeCoinsHelper(root);
        return moves;
    }
};