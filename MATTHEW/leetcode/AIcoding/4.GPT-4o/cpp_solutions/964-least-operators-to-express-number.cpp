class Solution {
public:
    int leastOpsExpressTarget(int x, int target) {
        if (target == 0) return 0;
        if (target == 1) return 1;

        int ops = 0;
        long long power = 1;
        while (power < target) {
            power *= x;
            ops++;
        }

        vector<int> dp(ops + 1, INT_MAX);
        dp[0] = 0;

        for (int i = 1; i <= ops; i++) {
            if (i > 1) {
                dp[i] = min(dp[i], dp[i - 1] + 1); // *x operation
            }
            long long val = 1;
            for (int j = i; j >= 0; j--) {
                if (val > target) break;
                if (val == target) {
                    dp[i] = min(dp[i], dp[j] + (i - j));
                }
                val *= x;
            }
        }

        return dp[ops];
    }
};