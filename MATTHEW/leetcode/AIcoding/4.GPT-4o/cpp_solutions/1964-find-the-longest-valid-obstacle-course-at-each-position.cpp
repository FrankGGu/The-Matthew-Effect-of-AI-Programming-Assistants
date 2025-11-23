class Solution {
public:
    vector<int> longestObstacleCourseAtEachPosition(vector<int>& obstacles) {
        int n = obstacles.size();
        vector<int> dp(n, 0);
        vector<int> lis;

        for (int i = 0; i < n; ++i) {
            if (lis.empty() || obstacles[i] >= lis.back()) {
                lis.push_back(obstacles[i]);
                dp[i] = lis.size();
            } else {
                auto it = lower_bound(lis.begin(), lis.end(), obstacles[i]);
                *it = obstacles[i];
                dp[i] = it - lis.begin() + 1;
            }
        }

        return dp;
    }
};