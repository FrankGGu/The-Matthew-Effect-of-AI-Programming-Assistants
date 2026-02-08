#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int fillCups(std::vector<int>& amount) {
        int sum = amount[0] + amount[1] + amount[2];
        int max_val = std::max({amount[0], amount[1], amount[2]});
        return std::max(max_val, (sum + 1) / 2);
    }
};