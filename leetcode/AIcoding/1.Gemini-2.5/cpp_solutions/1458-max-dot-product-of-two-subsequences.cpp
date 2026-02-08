#include <vector>
#include <algorithm>
#include <limits>

class Solution {
public:
    long long maxDotProduct(std::vector<int>& nums1, std::vector<int>& nums2) {
        int n = nums1.size();
        int m = nums2.size();

        std::vector<long long> prev_dp(m + 1, std::numeric_limits<long long>::min());
        std::vector<long long> curr_dp(m + 1, std::numeric_limits<long long>::min());

        for (int i = 1; i <= n; ++i) {
            for (int j = 1; j <= m; ++j) {
                long long current_product = (long long)nums1[i-1] * nums2[j-1];

                long long option1 = current_product;
                if (prev_dp[j-1] != std::numeric_limits<long long>::min()) {
                    option1 = std::max(option1, prev_dp[j-1] + current_product);
                }

                curr_dp[j] = option1;

                if (prev_dp[j] != std::numeric_limits<long long>::min()) {
                    curr_dp[j] = std::max(curr_dp[j], prev_dp[j]);
                }

                if (curr_dp[j-1] != std::numeric_limits<long long>::min()) {
                    curr_dp[j] = std::max(curr_dp[j], curr_dp[j-1]);
                }
            }
            prev_dp = curr_dp;
            curr_dp.assign(m + 1, std::numeric_limits<long long>::min());
        }

        return prev_dp[m];
    }
};