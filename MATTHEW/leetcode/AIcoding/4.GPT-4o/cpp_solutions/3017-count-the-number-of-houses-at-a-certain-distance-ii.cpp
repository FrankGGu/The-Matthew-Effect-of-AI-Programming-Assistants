class Solution {
public:
    int countHouses(int distance, vector<int>& houses) {
        int n = houses.size();
        vector<int> dp(n + 1, 0);
        dp[0] = 1;

        for (int i = 1; i <= n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (abs(houses[i - 1] - houses[j]) <= distance) {
                    dp[i] += dp[j];
                }
            }
        }

        return dp[n];
    }
};