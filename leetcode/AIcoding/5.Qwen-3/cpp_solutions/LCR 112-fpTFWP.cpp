#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestIncreasingPath(TreeNode* root) {
        if (!root) return 0;
        vector<vector<int>> dp(root->val, vector<int>(root->val, 0));
        int maxLen = 0;
        for (int i = 0; i < root->val; ++i) {
            for (int j = 0; j < root->val; ++j) {
                maxLen = max(maxLen, dfs(root, i, j, dp));
            }
        }
        return maxLen;
    }

private:
    int dfs(TreeNode* root, int i, int j, vector<vector<int>>& dp) {
        if (dp[i][j] != 0) return dp[i][j];
        int maxPath = 1;
        int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        for (auto& dir : directions) {
            int ni = i + dir[0];
            int nj = j + dir[1];
            if (ni >= 0 && ni < root->val && nj >= 0 && nj < root->val && root->val[ni][nj] > root->val[i][j]) {
                maxPath = max(maxPath, 1 + dfs(root, ni, nj, dp));
            }
        }
        dp[i][j] = maxPath;
        return maxPath;
    }
};