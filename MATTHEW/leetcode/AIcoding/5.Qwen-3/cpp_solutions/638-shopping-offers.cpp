#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int shoppingOffers(vector<int>& price, vector<vector<int>>& special, vector<int>& needs) {
        unordered_map<string, int> memo;
        return dfs(price, special, needs, memo);
    }

private:
    int dfs(vector<int>& price, vector<vector<int>>& special, vector<int>& needs, unordered_map<string, int>& memo) {
        string key = "";
        for (int n : needs) {
            key += to_string(n) + ",";
        }

        if (memo.find(key) != memo.end()) {
            return memo[key];
        }

        int total = 0;
        for (int i = 0; i < price.size(); ++i) {
            total += price[i] * needs[i];
        }

        for (const auto& offer : special) {
            bool valid = true;
            for (int i = 0; i < needs.size(); ++i) {
                if (needs[i] < offer[i]) {
                    valid = false;
                    break;
                }
            }
            if (valid) {
                for (int i = 0; i < needs.size(); ++i) {
                    needs[i] -= offer[i];
                }
                int cost = offer.back() + dfs(price, special, needs, memo);
                total = min(total, cost);
                for (int i = 0; i < needs.size(); ++i) {
                    needs[i] += offer[i];
                }
            }
        }

        memo[key] = total;
        return total;
    }
};