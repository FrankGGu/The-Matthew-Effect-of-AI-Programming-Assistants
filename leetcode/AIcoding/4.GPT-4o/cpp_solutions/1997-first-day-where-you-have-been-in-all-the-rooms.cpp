class Solution {
public:
    int firstDayBeenInAllRooms(vector<int>& nextVisit) {
        int n = nextVisit.size();
        long long mod = 1e9 + 7;
        vector<long long> dp(n);
        dp[0] = 0;
        for (int i = 1; i < n; ++i) {
            dp[i] = (dp[i - 1] * 2 + 1) % mod;
            dp[i] = (dp[i] + dp[nextVisit[i]] % mod) % mod;
        }
        return dp[n - 1];
    }
};