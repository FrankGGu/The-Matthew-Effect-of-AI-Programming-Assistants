#include <vector>
#include <algorithm>

class Solution {
public:
    int minimumCost(std::vector<int>& cost) {
        std::sort(cost.rbegin(), cost.rend());

        int totalCost = 0;
        int n = cost.size();

        for (int i = 0; i < n; i += 3) {
            totalCost += cost[i];
            if (i + 1 < n) {
                totalCost += cost[i + 1];
            }
        }

        return totalCost;
    }
};