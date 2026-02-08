#include <vector>
#include <algorithm> // For std::min

class Solution {
public:
    int minCost(std::vector<std::vector<int>>& costs) {
        if (costs.empty()) {
            return 0;
        }

        int n = costs.size();

        // Iterate through houses starting from the second house
        // For each house, calculate the minimum cost to paint it with each color,
        // considering the costs of painting previous houses.
        // costs[i][j] will store the minimum cost to paint houses 0 to i,
        // with house i painted with color j.
        for (int i = 1; i < n; ++i) {
            // If house i is painted with color 0, house i-1 must be painted with color 1 or 2.
            // We choose the minimum of these two options.
            costs[i][0] += std::min(costs[i-1][1], costs[i-1][2]);

            // If house i is painted with color 1, house i-1 must be painted with color 0 or 2.
            costs[i][1] += std::min(costs[i-1][0], costs[i-1][2]);

            // If house i is painted with color 2, house i-1 must be painted with color 0 or 1.
            costs[i][2] += std::min(costs[i-1][0], costs[i-1][1]);
        }

        // After iterating through all houses, the minimum cost to paint all houses
        // will be the minimum of the costs to paint the last house with each of the three colors.
        return std::min({costs[n-1][0], costs[n-1][1], costs[n-1][2]});
    }
};