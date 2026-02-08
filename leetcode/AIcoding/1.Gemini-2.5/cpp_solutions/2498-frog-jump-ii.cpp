#include <vector>
#include <algorithm>

class Solution {
public:
    int maxJump(std::vector<int>& stones) {
        int n = stones.size();

        int min_max_cost = stones[n-1] - stones[0];

        for (int k = 1; k < n - 1; ++k) {
            int current_max_cost_for_two_jumps = std::max(stones[k] - stones[0], stones[n-1] - stones[k]);
            min_max_cost = std::min(min_max_cost, current_max_cost_for_two_jumps);
        }

        return min_max_cost;
    }
};