class Solution {
public:
    int minimumOperations(vector<int>& nums, int start, int goal) {
        int n = nums.size();
        vector<bool> dp(2001, false);
        dp[start] = true;
        int operations = 0;

        while (operations <= n) {
            vector<bool> new_dp = dp;
            for (int i = 0; i < 2001; i++) {
                if (dp[i]) {
                    if (i == goal) return operations;
                    for (int num : nums) {
                        if (i + num < 2001) new_dp[i + num] = true;
                        if (i - num >= 0) new_dp[i - num] = true;
                    }
                }
            }
            dp = new_dp;
            operations++;
        }
        return -1;
    }
};