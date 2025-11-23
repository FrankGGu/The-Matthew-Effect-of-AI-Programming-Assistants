class Solution {
public:
    int concatenatedDivisibility(vector<int>& nums, int k) {
        int n = nums.size();
        vector<vector<int>> dp(1 << n, vector<int>(k, -1));
        return dfs(nums, k, 0, 0, 0, dp);
    }

private:
    int dfs(vector<int>& nums, int k, int mask, int pos, int mod, vector<vector<int>>& dp) {
        if (mask == (1 << nums.size()) - 1) {
            return mod == 0 ? 1 : 0;
        }
        if (dp[mask][mod] != -1) {
            return dp[mask][mod];
        }
        int res = 0;
        for (int i = 0; i < nums.size(); ++i) {
            if (!(mask & (1 << i))) {
                int new_mod = (mod * getMultiplier(nums[i]) % k + nums[i] % k) % k;
                res += dfs(nums, k, mask | (1 << i), pos + 1, new_mod, dp);
            }
        }
        dp[mask][mod] = res;
        return res;
    }

    int getMultiplier(int num) {
        int res = 1;
        while (num > 0) {
            res *= 10;
            num /= 10;
        }
        return res;
    }
};