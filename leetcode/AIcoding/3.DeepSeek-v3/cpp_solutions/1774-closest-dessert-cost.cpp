class Solution {
public:
    int closestCost(vector<int>& baseCosts, vector<int>& toppingCosts, int target) {
        int res = *min_element(baseCosts.begin(), baseCosts.end());
        for (int base : baseCosts) {
            dfs(toppingCosts, 0, base, target, res);
        }
        return res;
    }

    void dfs(vector<int>& toppingCosts, int idx, int cost, int target, int& res) {
        if (abs(cost - target) < abs(res - target) || 
            (abs(cost - target) == abs(res - target) && cost < res)) {
            res = cost;
        }
        if (cost >= target || idx == toppingCosts.size()) {
            return;
        }
        dfs(toppingCosts, idx + 1, cost, target, res);
        dfs(toppingCosts, idx + 1, cost + toppingCosts[idx], target, res);
        dfs(toppingCosts, idx + 1, cost + 2 * toppingCosts[idx], target, res);
    }
};