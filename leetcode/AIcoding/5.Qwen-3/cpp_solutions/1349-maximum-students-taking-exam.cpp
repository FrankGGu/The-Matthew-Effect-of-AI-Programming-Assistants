#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int maxStudents(vector<vector<int>>& seat) {
        int m = seat.size();
        int n = seat[0].size();

        vector<vector<int>> dp(m, vector<int>(1 << n, 0));
        vector<int> row_mask(m, 0);

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (seat[i][j] == 1) {
                    row_mask[i] |= (1 << j);
                }
            }
        }

        for (int i = 0; i < m; ++i) {
            for (int mask = 0; mask < (1 << n); ++mask) {
                if ((mask & row_mask[i]) != mask) continue;

                int cnt = 0;
                for (int j = 0; j < n; ++j) {
                    if (mask & (1 << j)) {
                        cnt++;
                    }
                }

                if (i == 0) {
                    dp[i][mask] = cnt;
                } else {
                    for (int prev_mask = 0; prev_mask < (1 << n); ++prev_mask) {
                        if ((prev_mask & mask) == 0) {
                            dp[i][mask] = max(dp[i][mask], dp[i - 1][prev_mask] + cnt);
                        }
                    }
                }
            }
        }

        int result = 0;
        for (int mask = 0; mask < (1 << n); ++mask) {
            result = max(result, dp[m - 1][mask]);
        }

        return result;
    }
};