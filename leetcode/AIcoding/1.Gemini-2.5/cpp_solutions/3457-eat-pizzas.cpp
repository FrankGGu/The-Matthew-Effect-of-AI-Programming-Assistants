#include <vector>
#include <algorithm>

class Solution {
public:
    int eatPizzas(std::vector<int>& pizzas) {
        if (pizzas.empty()) {
            return 0;
        }
        if (pizzas.size() == 1) {
            return pizzas[0];
        }

        int n = pizzas.size();
        std::vector<int> dp(n);

        dp[0] = pizzas[0];
        dp[1] = std::max(pizzas[0], pizzas[1]);

        for (int i = 2; i < n; ++i) {
            dp[i] = std::max(dp[i-1], dp[i-2] + pizzas[i]);
        }

        return dp[n-1];
    }
};