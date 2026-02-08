class Solution {
public:
    int numberWays(vector<vector<int>>& hats) {
        const int MOD = 1e9 + 7;
        int n = hats.size();
        vector<int> dp(1 << n, 0);
        dp[0] = 1;

        vector<vector<int>> hat_to_people(41);
        for (int i = 0; i < n; ++i) {
            for (int hat : hats[i]) {
                hat_to_people[hat].push_back(i);
            }
        }

        for (int hat = 1; hat <= 40; ++hat) {
            int people_count = hat_to_people[hat].size();
            for (int mask = (1 << n) - 1; mask >= 0; --mask) {
                for (int i = 0; i < people_count; ++i) {
                    int person_mask = 1 << hat_to_people[hat][i];
                    if (mask & person_mask) continue;
                    dp[mask | person_mask] = (dp[mask | person_mask] + dp[mask]) % MOD;
                }
            }
        }

        return dp[(1 << n) - 1];
    }
};