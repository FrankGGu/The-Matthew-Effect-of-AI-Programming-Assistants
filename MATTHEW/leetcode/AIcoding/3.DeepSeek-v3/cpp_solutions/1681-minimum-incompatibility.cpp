class Solution {
public:
    int minimumIncompatibility(vector<int>& nums, int k) {
        int n = nums.size();
        int m = n / k;
        sort(nums.begin(), nums.end());
        vector<int> dp(1 << n, INT_MAX);
        dp[0] = 0;
        for (int mask = 0; mask < (1 << n); ++mask) {
            if (dp[mask] == INT_MAX) continue;
            vector<int> used;
            for (int i = 0; i < n; ++i) {
                if (!(mask & (1 << i))) {
                    if (!used.empty() && nums[i] == used.back()) continue;
                    used.push_back(nums[i]);
                    if (used.size() == 1) {
                        int new_mask = mask | (1 << i);
                        dp[new_mask] = min(dp[new_mask], dp[mask]);
                    }
                    if (used.size() == m) {
                        int new_mask = mask;
                        for (int j = 0; j < m; ++j) {
                            int pos = lower_bound(nums.begin(), nums.end(), used[j]) - nums.begin();
                            int cnt = 0;
                            for (int l = pos; l < n; ++l) {
                                if (nums[l] != used[j]) break;
                                if (!(new_mask & (1 << l))) {
                                    ++cnt;
                                    if (cnt == 1) {
                                        new_mask |= (1 << l);
                                        break;
                                    }
                                }
                            }
                        }
                        dp[new_mask] = min(dp[new_mask], dp[mask] + used.back() - used[0]);
                    }
                }
            }
        }
        return dp[(1 << n) - 1] == INT_MAX ? -1 : dp[(1 << n) - 1];
    }
};