#include <iostream>
#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxIncreasingCells(const vector<vector<int>>& matrix) {
        int m = matrix.size();
        int n = matrix[0].size();
        vector<vector<int>> dp(m, vector<int>(n, 1));
        vector<vector<int>> count(10001, vector<int>(2, 0));         
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                count[matrix[i][j]][0]++;
                count[matrix[i][j]][1] = i * n + j;
            }
        }

        vector<vector<int>> dir = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        for (int val = 0; val <= 10000; ++val) {
            if (count[val][0] == 0) continue;
            int idx = count[val][1];
            int i = idx / n;
            int j = idx % n;
            for (int d = 0; d < 4; ++d) {
                int ni = i + dir[d][0];
                int nj = j + dir[d][1];
                if (ni >= 0 && ni < m && nj >= 0 && nj < n) {
                    if (matrix[ni][nj] < matrix[i][j]) {
                        dp[ni][nj] = max(dp[ni][nj], dp[i][j] + 1);
                    }
                }
            }
        }

        int result = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                result = max(result, dp[i][j]);
            }
        }
        return result;
    }
};