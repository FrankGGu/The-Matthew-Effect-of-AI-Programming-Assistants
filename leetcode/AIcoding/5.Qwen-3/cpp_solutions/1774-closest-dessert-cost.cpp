#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int closestCost(vector<int>& baseCosts, vector<int>& toppingCosts, int target) {
        int result = INT_MAX;
        for (int base : baseCosts) {
            dfs(base, 0, 0, target, toppingCosts, result);
        }
        return result;
    }

private:
    void dfs(int currentCost, int index, int count, int target, vector<int>& toppingCosts, int& result) {
        if (count == 2) {
            if (abs(currentCost - target) < abs(result - target)) {
                result = currentCost;
            } else if (abs(currentCost - target) == abs(result - target) && currentCost < result) {
                result = currentCost;
            }
            return;
        }
        if (index >= toppingCosts.size()) {
            if (abs(currentCost - target) < abs(result - target)) {
                result = currentCost;
            } else if (abs(currentCost - target) == abs(result - target) && currentCost < result) {
                result = currentCost;
            }
            return;
        }
        dfs(currentCost, index + 1, count, target, toppingCosts, result);
        dfs(currentCost + toppingCosts[index], index + 1, count + 1, target, toppingCosts, result);
        dfs(currentCost + 2 * toppingCosts[index], index + 1, count + 1, target, toppingCosts, result);
    }
};