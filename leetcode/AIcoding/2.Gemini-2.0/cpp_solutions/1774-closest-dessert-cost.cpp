#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int closestCost(vector<int>& baseCosts, vector<int>& toppingCosts, int target) {
        int minDiff = INT_MAX;
        int res = -1;

        function<void(int, int)> dfs = [&](int index, int currentCost) {
            int diff = abs(currentCost - target);
            if (diff < minDiff) {
                minDiff = diff;
                res = currentCost;
            } else if (diff == minDiff) {
                res = min(res, currentCost);
            }

            if (index == toppingCosts.size()) {
                return;
            }

            dfs(index + 1, currentCost);
            dfs(index + 1, currentCost + toppingCosts[index]);
            dfs(index + 1, currentCost + 2 * toppingCosts[index]);
        };

        for (int baseCost : baseCosts) {
            dfs(0, baseCost);
        }

        return res;
    }
};