#include <vector>
#include <algorithm>

class Solution {
public:
    long long maxSpending(std::vector<int>& prices) {
        std::sort(prices.begin(), prices.end());

        long long totalSpending = 0;
        int n = prices.size();

        for (int i = 0; i < n; ++i) {
            totalSpending += static_cast<long long>(prices[i]) * (i + 1);
        }

        return totalSpending;
    }
};