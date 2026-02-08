#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    int twoCitySchedCost(std::vector<std::vector<int>>& costs) {
        std::sort(costs.begin(), costs.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            return (a[0] - a[1]) < (b[0] - b[1]);
        });

        int totalCost = 0;
        int n = costs.size() / 2;

        for (int i = 0; i < n; ++i) {
            totalCost += costs[i][0];
        }

        for (int i = n; i < 2 * n; ++i) {
            totalCost += costs[i][1];
        }

        return totalCost;
    }
};