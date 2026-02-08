#include <iostream>
#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    int jobScheduling(vector<int>& startTime, vector<int>& endTime, vector<int>& profit) {
        vector<vector<int>> jobs;
        for (int i = 0; i < startTime.size(); ++i) {
            jobs.push_back({startTime[i], endTime[i], profit[i]});
        }
        sort(jobs.begin(), jobs.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[1] < b[1];
        });

        vector<int> dp;
        vector<int> endTimes;

        for (const auto& job : jobs) {
            int start = job[0], end = job[1], profit = job[2];
            int idx = lower_bound(endTimes.begin(), endTimes.end(), start) - endTimes.begin();
            int prevProfit = (idx > 0) ? dp[idx - 1] : 0;
            int currentProfit = profit + prevProfit;
            if (dp.empty() || currentProfit > dp.back()) {
                dp.push_back(currentProfit);
                endTimes.push_back(end);
            } else {
                auto it = upper_bound(endTimes.begin(), endTimes.end(), end);
                if (it != endTimes.end()) {
                    int pos = it - endTimes.begin();
                    if (currentProfit > dp[pos]) {
                        dp[pos] = currentProfit;
                    }
                } else {
                    dp.push_back(currentProfit);
                    endTimes.push_back(end);
                }
            }
        }
        return dp.empty() ? 0 : dp.back();
    }
};