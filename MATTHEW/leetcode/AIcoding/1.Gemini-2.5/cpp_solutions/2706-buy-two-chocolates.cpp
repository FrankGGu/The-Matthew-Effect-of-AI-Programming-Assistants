#include <vector>
#include <algorithm>

class Solution {
public:
    int buyChoco(std::vector<int>& prices, int money) {
        std::sort(prices.begin(), prices.end());

        int cost = prices[0] + prices[1];

        if (money >= cost) {
            return money - cost;
        } else {
            return money;
        }
    }
};