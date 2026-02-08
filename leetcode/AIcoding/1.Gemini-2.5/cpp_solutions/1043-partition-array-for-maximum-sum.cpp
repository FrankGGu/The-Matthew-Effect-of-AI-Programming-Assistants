#include <vector>
#include <algorithm>

class Solution {
public:
    int maxSumAfterPartitioning(std::vector<int>& arr, int k) {
        int n = arr.size();
        std::vector<int> dp(n + 1, 0);

        for (int i = 1; i <= n; ++i) {
            int current_max = 0;
            for (int j = 1; j <= k && i - j >= 0; ++j) {
                current_max = std::max(current_max, arr[i - j]);
                dp[i] = std::max(dp[i], dp[i - j] + current_max * j);
            }
        }

        return dp[n];
    }
};