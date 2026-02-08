class Solution {
public:
    int stoneGameVII(vector<int>& stones) {
        int total = accumulate(stones.begin(), stones.end(), 0);
        int left = 0, right = total;
        int n = stones.size();
        int dp[2] = {0, 0};

        for (int i = 0; i < n; ++i) {
            dp[i % 2] = max(dp[i % 2], left + right - stones[i]);
            left += stones[i];
            right -= stones[i];
        }

        return dp[(n - 1) % 2];
    }
};