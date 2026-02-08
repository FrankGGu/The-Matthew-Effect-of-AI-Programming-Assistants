#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximizeGridHappiness(int m, int n, int k) {
        vector<vector<int>> dp(2, vector<int>(1 << k, -1));
        dp[0][0] = 0;
        for (int i = 0; i < m; ++i) {
            vector<vector<int>> new_dp(2, vector<int>(1 << k, -1));
            for (int j = 0; j < n; ++j) {
                vector<vector<int>> next_dp(2, vector<int>(1 << k, -1));
                for (int state = 0; state < (1 << k); ++state) {
                    if (dp[0][state] == -1) continue;
                    for (int prev = 0; prev < 2; ++prev) {
                        for (int curr = 0; curr < 2; ++curr) {
                            int new_state = state;
                            int add = 0;
                            if (curr == 1) {
                                add += 3;
                                for (int p = 0; p < k; ++p) {
                                    if ((state >> p) & 1) {
                                        add += 2;
                                    }
                                }
                                if (prev == 1) add += 2;
                            }
                            if (prev == 1 && curr == 1) add += 2;
                            int new_val = dp[0][state] + add;
                            int new_state_bit = 0;
                            for (int p = 0; p < k; ++p) {
                                if ((state >> p) & 1) {
                                    new_state_bit |= (1 << p);
                                }
                            }
                            if (curr == 1) {
                                new_state_bit |= (1 << (k - 1));
                            }
                            new_state_bit &= (1 << k) - 1;
                            next_dp[curr][new_state_bit] = max(next_dp[curr][new_state_bit], new_val);
                        }
                    }
                }
                dp = next_dp;
            }
        }
        int result = 0;
        for (int state = 0; state < (1 << k); ++state) {
            result = max(result, dp[0][state]);
        }
        return result;
    }
};