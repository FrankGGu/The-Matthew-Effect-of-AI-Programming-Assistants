#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int coinBonus(std::vector<int>& coins) {
        if (coins.empty()) {
            return 0;
        }
        long long totalBonus = std::accumulate(coins.begin(), coins.end(), 0LL);
        return static_cast<int>(totalBonus);
    }
};