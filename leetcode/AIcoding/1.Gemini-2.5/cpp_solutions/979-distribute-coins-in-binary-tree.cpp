#include <cmath>

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
    int distributeCoins(TreeNode* root) {
        moves = 0;
        dfs(root);
        return moves;
    }

private:
    int moves;

    int dfs(TreeNode* node) {
        if (!node) {
            return 0;
        }

        int left_balance = dfs(node->left);
        int right_balance = dfs(node->right);

        moves += std::abs(left_balance) + std::abs(right_balance);

        return node->val - 1 + left_balance + right_balance;
    }
};