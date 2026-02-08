class Solution {
public:
    int squareFreeSubsets(vector<int>& nums) {
        const int MOD = 1e9 + 7;
        vector<int> count(101, 0);
        for (int num : nums) count[num]++;

        vector<int> square_free_nums;
        for (int i = 1; i < 101; ++i) {
            if (count[i] > 0) {
                square_free_nums.push_back(i);
            }
        }

        int n = square_free_nums.size();
        vector<vector<int>> dp(n + 1, vector<int>(1 << n, 0));
        dp[0][0] = 1;

        for (int i = 0; i < n; ++i) {
            int num = square_free_nums[i];
            for (int mask = 0; mask < (1 << n); ++mask) {
                dp[i + 1][mask] = (dp[i][mask] + dp[i + 1][mask]) % MOD; // Not take current number
                for (int j = 0; j < count[num]; ++j) {
                    bool valid = true;
                    for (int k = 0; k < i; ++k) {
                        if (mask & (1 << k) && (square_free_nums[k] * square_free_nums[k]) % num == 0) {
                            valid = false;
                            break;
                        }
                    }
                    if (valid) {
                        dp[i + 1][mask | (1 << i)] = (dp[i + 1][mask | (1 << i)] + dp[i][mask]) % MOD; // Take current number
                    }
                }
            }
        }

        int result = 0;
        for (int mask = 1; mask < (1 << n); ++mask) {
            result = (result + dp[n][mask]) % MOD;
        }

        return result;
    }
};