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

        count[n - 1][n - 1] = 1;

        for (int i = n - 1; i >= 0; --i) {
            for (int j = n - 1; j >= 0; --j) {
                if (board[i][j] == 'X') {
                    dp[i][j] = 0;
                    count[i][j] = 0;
                    continue;
                }

                if (i == n - 1 && j == n - 1) {
                    dp[i][j] = 0;
                    count[i][j] = 1;
                    continue;
                }

                int val = (board[i][j] == 'S') ? 0 : (board[i][j] - '0');

                int max_score = 0;
                int total_count = 0;

                if (i + 1 < n && count[i + 1][j] > 0) {
                    max_score = max(max_score, dp[i + 1][j] + val);
                }
                if (j + 1 < n && count[i][j + 1] > 0) {
                    max_score = max(max_score, dp[i][j + 1] + val);
                }
                if (i + 1 < n && j + 1 < n && count[i + 1][j + 1] > 0) {
                    max_score = max(max_score, dp[i + 1][j + 1] + val);
                }

                dp[i][j] = max_score;

                if (i + 1 < n && count[i + 1][j] > 0 && dp[i + 1][j] + val == max_score) {
                    total_count = (total_count + count[i + 1][j]) % 1000000007;
                }
                if (j + 1 < n && count[i][j + 1] > 0 && dp[i][j + 1] + val == max_score) {
                    total_count = (total_count + count[i][j + 1]) % 1000000007;
                }
                if (i + 1 < n && j + 1 < n && count[i + 1][j + 1] > 0 && dp[i + 1][j + 1] + val == max_score) {
                    total_count = (total_count + count[i + 1][j + 1]) % 1000000007;
                }

                count[i][j] = total_count;
            }
        }

        return {dp[0][0], count[0][0]};
    }
};