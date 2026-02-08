#include <vector>
#include <algorithm>
#include <map>

using namespace std;

class Solution {
public:
    int shoppingOffers(vector<int>& price, vector<vector<int>>& special, vector<int>& needs) {
        int n = price.size();
        int ans = 0;
        for (int i = 0; i < n; ++i) {
            ans += price[i] * needs[i];
        }

        function<int(vector<int>&)> solve = [&](vector<int>& cur_needs) {
            int min_cost = 0;
            for (int i = 0; i < n; ++i) {
                min_cost += price[i] * cur_needs[i];
            }

            for (auto& offer : special) {
                bool valid = true;
                vector<int> next_needs(n);
                for (int i = 0; i < n; ++i) {
                    next_needs[i] = cur_needs[i] - offer[i];
                    if (next_needs[i] < 0) {
                        valid = false;
                        break;
                    }
                }

                if (valid) {
                    min_cost = min(min_cost, offer[n] + solve(next_needs));
                }
            }
            return min_cost;
        };

        return solve(needs);
    }
};