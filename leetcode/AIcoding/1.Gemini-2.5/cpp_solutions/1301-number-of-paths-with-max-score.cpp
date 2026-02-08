#include <vector>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> pathsWithMaxScore(vector<string>& board) {
        int n = board.size();
        vector<vector<int>> dp(n, vector<int>(n, 0));
        vector<vector<int>> count(n, vector<int>(n, 0));

        if (board[n - 1][n - 1] != 'X') {
            dp[n - 1][n - 1] = 0;
            count[n - 1][n - 1] = 1;
        }

        for (int i = n - 1; i >= 0; --i) {
            for (int j = n - 1; j >= 0; --j) {
                if (board[i][j] == 'X') continue;

                int current_val = (i == n - 1 && j == n - 1) ? 0 : (board[i][j] - '0');

                int max_score = -1;
                int total_paths = 0;

                if (i + 1 < n && count[i + 1][j] > 0) {
                    if (dp[i + 1][j] + current_val > max_score) {
                        max_score = dp[i + 1][j] + current_val;
                        total_paths = count[i + 1][j];
                    } else if (dp[i + 1][j] + current_val == max_score) {
                        total_paths = (total_paths + count[i + 1][j]) % 1000000007;
                    }
                }

                if (j + 1 < n && count[i][j + 1] > 0) {
                    if (dp[i][j + 1] + current_val > max_score) {
                        max_score = dp[i][j + 1] + current_val;
                        total_paths = count[i][j + 1];
                    } else if (dp[i][j + 1] + current_val == max_score) {
                        total_paths = (total_paths + count[i][j + 1]) % 1000000007;
                    }
                }

                if (i + 1 < n && j + 1 < n && count[i + 1][j + 1] > 0) {
                    if (dp[i + 1][j + 1] + current_val > max_score) {
                        max_score = dp[i + 1][j + 1] + current_val;
                        total_paths = count[i + 1][j + 1];
                    } else if (dp[i + 1][j + 1] + current_val == max_score) {
                        total_paths = (total_paths + count[i + 1][j + 1]) % 1000000007;
                    }
                }

                if (max_score != -1) {
                    dp[i][j] = max_score;
                    count[i][j] = total_paths;
                }
            }
        }

        return {dp[0][0], count[0][0]};
    }
};