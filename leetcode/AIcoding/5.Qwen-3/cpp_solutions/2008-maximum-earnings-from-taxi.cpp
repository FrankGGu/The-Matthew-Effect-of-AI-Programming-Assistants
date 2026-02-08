#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxTaxiEarnings(int n, vector<vector<int>>& rides) {
        sort(rides.begin(), rides.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] < b[1];
        });

        vector<long long> dp(n + 1, 0);
        int j = 0;

        for (int i = 1; i <= n; ++i) {
            while (j < rides.size() && rides[j][1] == i) {
                int start = rides[j][0];
                int end = rides[j][1];
                int earn = rides[j][2];
                dp[i] = max(dp[i], dp[start] + earn);
                ++j;
            }
            dp[i] = max(dp[i], dp[i - 1]);
        }

        return dp[n];
    }
};