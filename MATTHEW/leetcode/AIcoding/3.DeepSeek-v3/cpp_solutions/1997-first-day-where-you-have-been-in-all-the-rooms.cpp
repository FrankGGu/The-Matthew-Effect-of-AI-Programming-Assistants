class Solution {
public:
    int firstDayBeenInAllRooms(vector<int>& nextVisit) {
        int n = nextVisit.size();
        const int MOD = 1e9 + 7;
        vector<long long> dp(n, 0);

        for (int i = 1; i < n; ++i) {
            dp[i] = (2 * dp[i - 1] - dp[nextVisit[i - 1]] + 2 + MOD) % MOD;
        }

        return dp[n - 1];
    }
};