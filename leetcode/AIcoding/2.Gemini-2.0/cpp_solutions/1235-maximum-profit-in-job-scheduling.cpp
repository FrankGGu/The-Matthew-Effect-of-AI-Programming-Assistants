#include <vector>
#include <algorithm>

using namespace std;

struct Job {
    int start, end, profit;
};

int jobScheduling(vector<int>& startTime, vector<int>& endTime, vector<int>& profit) {
    int n = startTime.size();
    vector<Job> jobs(n);
    for (int i = 0; i < n; ++i) {
        jobs[i] = {startTime[i], endTime[i], profit[i]};
    }

    sort(jobs.begin(), jobs.end(), [](const Job& a, const Job& b) {
        return a.end < b.end;
    });

    vector<int> dp(n);
    dp[0] = jobs[0].profit;

    for (int i = 1; i < n; ++i) {
        int currentProfit = jobs[i].profit;
        int prevJobIndex = -1;
        for (int j = i - 1; j >= 0; --j) {
            if (jobs[j].end <= jobs[i].start) {
                prevJobIndex = j;
                break;
            }
        }

        if (prevJobIndex != -1) {
            currentProfit += dp[prevJobIndex];
        }

        dp[i] = max(dp[i - 1], currentProfit);
    }

    return dp[n - 1];
}