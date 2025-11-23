#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestIncreasingPath(TreeNode* root) {
        if (!root) return 0;
        vector<vector<int>> dp(root->val + 1, vector<int>(root->val + 1, -1));
        return dfs(root, dp);
    }

private:
    int dfs(TreeNode* node, vector<vector<int>>& dp) {
        if (dp[node->val][node->val] != -1) return dp[node->val][node->val];
        int maxPath = 1;
        if (node->left) {
            if (node->left->val > node->val) {
                maxPath = max(maxPath, 1 + dfs(node->left, dp));
            }
        }
        if (node->right) {
            if (node->right->val > node->val) {
                maxPath = max(maxPath, 1 + dfs(node->right, dp));
            }
        }
        dp[node->val][node->val] = maxPath;
        return maxPath;
    }
};