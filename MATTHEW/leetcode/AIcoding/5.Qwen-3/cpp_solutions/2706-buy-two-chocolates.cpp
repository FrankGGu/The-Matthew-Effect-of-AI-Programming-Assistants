#include <iostream>
#include <vector>
#include <algorithm>

class Solution {
public:
    int buyChocolates(std::vector<int>& prices, int money) {
        std::sort(prices.begin(), prices.end());
        int total = prices[0] + prices[1];
        if (total <= money) {
            return money - total;
        } else {
            return money;
        }
    }
};