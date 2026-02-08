#include <iostream>
#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    long long minimumMoney(std::vector<std::vector<int>>& transactions) {
        long long total_loss = 0;
        int max_val = 0;

        for (const auto& t : transactions) {
            int cost = t[0];
            int cashback = t[1];
            if (cost > cashback) {
                total_loss += (long long)cost - cashback;
                max_val = std::max(max_val, cashback);
            } else {
                max_val = std::max(max_val, cost);
            }
        }

        return total_loss + max_val;
    }
};