#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int maximumWealth(std::vector<std::vector<int>>& accounts) {
        int max_wealth = 0;
        for (const auto& customer_accounts : accounts) {
            max_wealth = std::max(max_wealth, std::accumulate(customer_accounts.begin(), customer_accounts.end(), 0));
        }
        return max_wealth;
    }
};