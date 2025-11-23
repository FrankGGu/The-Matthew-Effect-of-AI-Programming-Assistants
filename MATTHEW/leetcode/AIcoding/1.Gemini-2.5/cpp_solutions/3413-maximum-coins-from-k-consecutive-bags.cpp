#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    long long maxCoins(std::vector<int>& coins, int k) {
        if (coins.empty() || k == 0) {
            return 0;
        }

        long long current_window_sum = 0;

        for (int i = 0; i < k; ++i) {
            current_window_sum += coins[i];
        }

        long long max_overall_sum = current_window_sum;

        for (int i = k; i < coins.size(); ++i) {
            current_window_sum += coins[i] - coins[i - k];
            max_overall_sum = std::max(max_overall_sum, current_window_sum);
        }

        return max_overall_sum;
    }
};