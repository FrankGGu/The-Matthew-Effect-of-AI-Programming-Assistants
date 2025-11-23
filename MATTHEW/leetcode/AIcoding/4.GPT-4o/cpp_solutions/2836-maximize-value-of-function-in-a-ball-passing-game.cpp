class Solution {
public:
    int maxValueOfCoins(vector<vector<int>>& piles, int k) {
        int n = piles.size();
        vector<int> dp(k + 1, 0);

        for (int i = 0; i < n; ++i) {
            int m = piles[i].size();
            for (int j = k; j >= 0; --j) {
                int sum = 0;
                for (int x = 0; x < min(m, j); ++x) {
                    sum += piles[i][x];
                    dp[j] = max(dp[j], dp[j - x - 1] + sum);
                }
            }
        }

        return dp[k];
    }
};