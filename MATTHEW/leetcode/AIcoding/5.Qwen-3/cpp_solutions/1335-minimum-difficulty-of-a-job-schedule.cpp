#include <iostream>
#include <vector>
#include <climits>

using namespace std;

class Solution {
public:
    int minDifficulty(vector<int>& jobDifficulty, int d) {
        int n = jobDifficulty.size();
        if (n < d) return -1;

        vector<int> dp(n, 0);
        for (int i = 0; i < n; ++i) {
            dp[i] = jobDifficulty[i];
        }

        for (int day = 1; day < d; ++day) {
            vector<int> new_dp(n - day, INT_MAX);
            for (int i = 0; i < n - day; ++i) {
                int max_diff = jobDifficulty[i];
                for (int j = i + 1; j <= n - day; ++j) {
                    max_diff = max(max_diff, jobDifficulty[j]);
                    new_dp[i] = min(new_dp[i], dp[j] + max_diff);
                }
            }
            dp = new_dp;
        }

        return dp[0];
    }
};