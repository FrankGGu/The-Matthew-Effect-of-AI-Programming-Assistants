class Solution {
public:
    int maximizeHappiness(vector<int>& happiness, vector<vector<int>>& groups) {
        int n = happiness.size();
        int m = groups.size();
        vector<int> dp(1 << n, 0);

        for (int mask = 0; mask < (1 << n); ++mask) {
            for (int i = 0; i < m; ++i) {
                int groupMask = 0;
                for (int j : groups[i]) {
                    groupMask |= (1 << j);
                }
                if ((mask & groupMask) != groupMask) continue;

                int currentHappiness = 0;
                for (int j = 0; j < n; ++j) {
                    if (mask & (1 << j) && (groupMask & (1 << j))) {
                        currentHappiness += happiness[j];
                    }
                }
                dp[mask] = max(dp[mask], dp[mask ^ groupMask] + currentHappiness);
            }
        }
        return dp[(1 << n) - 1];
    }
};