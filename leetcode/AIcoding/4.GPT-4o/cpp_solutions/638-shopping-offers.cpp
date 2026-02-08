class Solution {
public:
    int shoppingOffers(vector<int>& price, vector<vector<int>>& special, vector<int>& needs) {
        return dfs(price, special, needs);
    }

private:
    int dfs(vector<int>& price, vector<vector<int>>& special, vector<int>& needs) {
        int n = needs.size();
        int cost = 0;
        for (int i = 0; i < n; ++i) {
            cost += needs[i] * price[i];
        }
        for (const auto& offer : special) {
            vector<int> newNeeds = needs;
            bool valid = true;
            for (int i = 0; i < n; ++i) {
                if (newNeeds[i] < offer[i]) {
                    valid = false;
                    break;
                }
                newNeeds[i] -= offer[i];
            }
            if (valid) {
                cost = min(cost, offer[n] + dfs(price, special, newNeeds));
            }
        }
        return cost;
    }
};