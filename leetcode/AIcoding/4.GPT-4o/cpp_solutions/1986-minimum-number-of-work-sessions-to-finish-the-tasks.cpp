class Solution {
public:
    int minSessions(vector<int>& tasks, int sessionTime) {
        int n = tasks.size();
        int ans = INT_MAX;
        vector<int> dp(1 << n, INT_MAX);
        dp[0] = 0;

        for (int mask = 0; mask < (1 << n); ++mask) {
            int currentTime = 0;
            for (int i = 0; i < n; ++i) {
                if (mask & (1 << i)) {
                    currentTime += tasks[i];
                }
            }
            if (currentTime > sessionTime) continue;
            for (int i = 0; i < n; ++i) {
                if (!(mask & (1 << i))) {
                    int newMask = mask | (1 << i);
                    int newTime = currentTime + tasks[i];
                    if (newTime <= sessionTime) {
                        dp[newMask] = min(dp[newMask], dp[mask]);
                    } else {
                        dp[newMask] = min(dp[newMask], dp[mask] + 1);
                    }
                }
            }
        }

        return dp[(1 << n) - 1];
    }
};