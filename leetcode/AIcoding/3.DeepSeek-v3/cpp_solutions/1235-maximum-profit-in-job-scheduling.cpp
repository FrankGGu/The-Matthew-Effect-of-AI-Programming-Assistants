class Solution {
public:
    int jobScheduling(vector<int>& startTime, vector<int>& endTime, vector<int>& profit) {
        int n = startTime.size();
        vector<vector<int>> jobs;
        for (int i = 0; i < n; ++i) {
            jobs.push_back({endTime[i], startTime[i], profit[i]});
        }
        sort(jobs.begin(), jobs.end());

        vector<int> dp(n + 1);
        for (int i = 1; i <= n; ++i) {
            int prev = 0;
            int low = 0, high = i - 1;
            while (low <= high) {
                int mid = (low + high) / 2;
                if (jobs[mid][0] <= jobs[i-1][1]) {
                    prev = mid + 1;
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }
            dp[i] = max(dp[i-1], dp[prev] + jobs[i-1][2]);
        }
        return dp[n];
    }
};