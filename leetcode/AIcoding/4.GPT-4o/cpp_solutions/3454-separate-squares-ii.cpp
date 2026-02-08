class Solution {
public:
    int separateSquares(vector<int>& nums) {
        int n = nums.size();
        vector<int> dp(n + 1, 0);
        for (int i = 1; i <= n; ++i) {
            dp[i] = dp[i - 1];
            for (int j = 0; j < i; ++j) {
                if (isSquare(nums[j]) && isSquare(nums[i - 1])) {
                    dp[i] = max(dp[i], dp[j] + 1);
                }
            }
        }
        return dp[n];
    }

private:
    bool isSquare(int x) {
        int s = sqrt(x);
        return s * s == x;
    }
};