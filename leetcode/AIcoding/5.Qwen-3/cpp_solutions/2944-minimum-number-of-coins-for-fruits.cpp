#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int minCoins(vector<int>& fruits, vector<int>& coins) {
        unordered_map<int, int> coinMap;
        for (int i = 0; i < coins.size(); ++i) {
            coinMap[coins[i]] = i + 1;
        }

        vector<int> dp(fruits.size() + 1, 0);
        for (int i = 1; i <= fruits.size(); ++i) {
            dp[i] = dp[i - 1] + 1;
            for (auto& [coin, index] : coinMap) {
                if (i >= coin && dp[i - coin] + 1 < dp[i]) {
                    dp[i] = dp[i - coin] + 1;
                }
            }
        }

        return dp[fruits.size()];
    }
};