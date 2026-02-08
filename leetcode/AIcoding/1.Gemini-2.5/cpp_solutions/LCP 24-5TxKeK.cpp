#include <vector>
#include <unordered_set>
#include <numeric>

class Solution {
public:
    int numGame(std::vector<int>& nums, int target) {
        int n = nums.size();
        if (n == 0) {
            return -1;
        }

        std::vector<std::unordered_set<int>> dp(1 << n);

        for (int i = 0; i < n; ++i) {
            dp[1 << i].insert(nums[i]);
            if (nums[i] == target) {
                return 0;
            }
        }

        for (int k = 2; k <= n; ++k) {
            for (int mask = 1; mask < (1 << n); ++mask) {
                if (__builtin_popcount(mask) != k) {
                    continue;
                }

                for (int submask = (mask - 1) & mask; submask > 0; submask = (submask - 1) & mask) {
                    int other_submask = mask ^ submask;
                    if (submask > other_submask) {
                        continue;
                    }

                    if (dp[submask].empty() || dp[other_submask].empty()) {
                        continue;
                    }

                    for (int v1 : dp[submask]) {
                        for (int v2 : dp[other_submask]) {
                            dp[mask].insert(v1 + v2);
                            dp[mask].insert(v1 - v2);
                            dp[mask].insert(v2 - v1);
                            dp[mask].insert(v1 * v2);
                            if (v2 != 0) {
                                dp[mask].insert(v1 / v2);
                                dp[mask].insert(v1 % v2);
                            }
                            if (v1 != 0) {
                                dp[mask].insert(v2 / v1);
                                dp[mask].insert(v2 % v1);
                            }
                        }
                    }
                }
            }

            for (int mask = 1; mask < (1 << n); ++mask) {
                if (__builtin_popcount(mask) == k) {
                    if (dp[mask].count(target)) {
                        return k - 1;
                    }
                }
            }
        }

        return -1;
    }
};