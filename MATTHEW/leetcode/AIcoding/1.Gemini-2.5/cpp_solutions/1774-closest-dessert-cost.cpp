#include <vector>
#include <cmath>
#include <algorithm>
#include <climits>

class Solution {
private:
    int result;
    int minDiff;

    void dfs(int index, int currentCost, const std::vector<int>& toppingCosts, int target) {
        int diff = std::abs(currentCost - target);
        if (diff < minDiff) {
            minDiff = diff;
            result = currentCost;
        } else if (diff == minDiff) {
            result = std::min(result, currentCost);
        }

        if (index == toppingCosts.size() || currentCost >= target + minDiff) {
            return;
        }

        dfs(index + 1, currentCost, toppingCosts, target);
        dfs(index + 1, currentCost + toppingCosts[index], toppingCosts, target);
        dfs(index + 1, currentCost + 2 * toppingCosts[index], toppingCosts, target);
    }

public:
    int closestCost(std::vector<int>& baseCosts, std::vector<int>& toppingCosts, int target) {
        minDiff = INT_MAX;
        result = INT_MAX;

        for (int base : baseCosts) {
            dfs(0, base, toppingCosts, target);
        }

        return result;
    }
};