#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int kthLargestValue(vector<vector<int>>& matrix, int k) {
        int m = matrix.size();
        int n = matrix[0].size();
        vector<vector<int>> dp(m, vector<int>(n, 0));
        vector<int> results;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i == 0 && j == 0) {
                    dp[i][j] = matrix[i][j];
                } else if (i == 0) {
                    dp[i][j] = dp[i][j - 1] ^ matrix[i][j];
                } else if (j == 0) {
                    dp[i][j] = dp[i - 1][j] ^ matrix[i][j];
                } else {
                    dp[i][j] = dp[i - 1][j] ^ dp[i][j - 1] ^ dp[i - 1][j - 1] ^ matrix[i][j];
                }
                results.push_back(dp[i][j]);
            }
        }

        sort(results.begin(), results.end(), greater<int>());
        return results[k - 1];
    }
};