#include <string>
#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int minCost(std::string colors, std::vector<int>& neededTime) {
        int n = colors.length();
        if (n <= 1) {
            return 0;
        }

        int total_cost = 0;
        int current_block_sum = 0;
        int current_block_max = 0;

        // Initialize for the first balloon
        current_block_sum = neededTime[0];
        current_block_max = neededTime[0];

        for (int i = 1; i < n; ++i) {
            if (colors[i] == colors[i - 1]) {
                // Same color, continue the current block
                current_block_sum += neededTime[i];
                current_block_max = std::max(current_block_max, neededTime[i]);
            } else {
                // Different color, the previous block has ended
                // Add the cost for removing balloons in the previous block
                total_cost += (current_block_sum - current_block_max);

                // Start a new block with the current balloon
                current_block_sum = neededTime[i];
                current_block_max = neededTime[i];
            }
        }

        // After the loop, add the cost for the very last block
        total_cost += (current_block_sum - current_block_max);

        return total_cost;
    }
};