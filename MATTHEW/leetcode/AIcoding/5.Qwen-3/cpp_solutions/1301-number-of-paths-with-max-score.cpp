#include <iostream>
#include <vector>
#include <string>
using namespace std;

class Solution {
public:
    vector<int> maxPathSum(vector<string>& board) {
        int n = board.size();
        vector<vector<int>> dp(n, vector<int>(n, -1));
        vector<vector<int>> count(n, vector<int>(n, 0));
        dp[0][0] = board[0][0] - '0';
        count[0][0] = 1;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i == 0 && j == 0) continue;
                if (board[i][j] == 'X') {
                    dp[i][j] = -1;
                    continue;
                }
                int maxVal = -1;
                int cnt = 0;
                if (i > 0 && dp[i-1][j] != -1) {
                    maxVal = max(maxVal, dp[i-1][j]);
                }
                if (j > 0 && dp[i][j-1] != -1) {
                    maxVal = max(maxVal, dp[i][j-1]);
                }
                if (i > 0 && j > 0 && dp[i-1][j-1] != -1) {
                    maxVal = max(maxVal, dp[i-1][j-1]);
                }
                if (maxVal != -1) {
                    dp[i][j] = maxVal + (board[i][j] - '0');
                    if (i > 0 && dp[i-1][j] == maxVal) cnt += count[i-1][j];
                    if (j > 0 && dp[i][j-1] == maxVal) cnt += count[i][j-1];
                    if (i > 0 && j > 0 && dp[i-1][j-1] == maxVal) cnt += count[i-1][j-1];
                } else {
                    dp[i][j] = -1;
                }
                count[i][j] = cnt;
            }
        }

        if (dp[n-1][n-1] == -1) return {-1, 0};
        return {dp[n-1][n-1], count[n-1][n-1]};
    }
};