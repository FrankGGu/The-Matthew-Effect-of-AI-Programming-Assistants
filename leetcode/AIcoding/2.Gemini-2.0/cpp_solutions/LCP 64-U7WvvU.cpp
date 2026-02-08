class Solution {
public:
    int minFlips(TreeNode* root) {
        pair<int, int> result = solve(root);
        return min(result.first, result.second);
    }

private:
    pair<int, int> solve(TreeNode* node) {
        if (!node) {
            return {0, 1};
        }

        pair<int, int> left = solve(node->left);
        pair<int, int> right = solve(node->right);

        int lit = min(left.first, left.second) + min(right.first, right.second);
        int notLit = min(left.first, left.second) + min(right.first, right.second) + 1;

        return {notLit, lit};
    }
};