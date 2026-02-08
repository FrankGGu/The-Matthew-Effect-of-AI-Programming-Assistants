#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long mostPoints(vector<vector<int>>& questions) {
        int n = questions.size();
        vector<long long> dp(n, 0);

        for (int i = n - 1; i >= 0; i--) {
            int score = questions[i][0];
            int jump = questions[i][1];
            if (i + jump + 1 < n) {
                dp[i] = max(score + dp[i + jump + 1], dp[i + 1]);
            } else {
                dp[i] = max(score, dp[i + 1]);
            }
        }

        return dp[0];
    }
};