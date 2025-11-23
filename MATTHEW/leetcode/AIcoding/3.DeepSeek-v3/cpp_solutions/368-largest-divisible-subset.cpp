class Solution {
public:
    vector<int> largestDivisibleSubset(vector<int>& nums) {
        if (nums.empty()) return {};
        sort(nums.begin(), nums.end());
        int n = nums.size();
        vector<int> dp(n, 1), parent(n, -1);
        int max_len = 1, max_idx = 0;

        for (int i = 1; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (nums[i] % nums[j] == 0 && dp[i] < dp[j] + 1) {
                    dp[i] = dp[j] + 1;
                    parent[i] = j;
                }
            }
            if (dp[i] > max_len) {
                max_len = dp[i];
                max_idx = i;
            }
        }

        vector<int> result;
        while (max_idx != -1) {
            result.push_back(nums[max_idx]);
            max_idx = parent[max_idx];
        }
        reverse(result.begin(), result.end());
        return result;
    }
};