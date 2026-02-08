class Solution {
public:
    int findValidSplit(vector<int>& nums) {
        int n = nums.size();
        vector<int> gcd(n + 1);
        vector<bool> dp(n + 1, false);
        dp[0] = true;

        for (int i = 1; i <= n; ++i) {
            gcd[i] = nums[i - 1];
            for (int j = i; j > 0; --j) {
                gcd[j] = __gcd(gcd[j], nums[i - 1]);
                if (gcd[j] == 1 && dp[j - 1]) {
                    dp[j] = true;
                }
            }
        }

        for (int i = n; i > 0; --i) {
            if (dp[i]) return n - i;
        }

        return -1;
    }
};