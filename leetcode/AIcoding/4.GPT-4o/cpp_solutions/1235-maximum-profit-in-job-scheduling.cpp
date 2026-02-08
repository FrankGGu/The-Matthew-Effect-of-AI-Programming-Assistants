#include <vector>
#include <algorithm>
#include <tuple>

using namespace std;

class Solution {
public:
    int jobScheduling(vector<int>& startTime, vector<int>& endTime, vector<int>& profit) {
        vector<tuple<int, int, int>> jobs;
        for (int i = 0; i < startTime.size(); ++i) {
            jobs.emplace_back(endTime[i], startTime[i], profit[i]);
        }
        sort(jobs.begin(), jobs.end());

        int n = jobs.size();
        vector<int> dp(n + 1, 0);

        for (int i = 1; i <= n; ++i) {
            int currentProfit = get<2>(jobs[i - 1]);
            int idx = lower_bound(jobs.begin(), jobs.end(), make_tuple(get<1>(jobs[i - 1]), 0, 0)) - jobs.begin();
            dp[i] = max(dp[i - 1], dp[idx] + currentProfit);
        }

        return dp[n];
    }
};