#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int eatPizzas(vector<int>& pizzas, int k) {
        int n = pizzas.size();
        vector<vector<int>> dp(k + 1, vector<int>(n, 0));

        for (int i = 0; i < n; ++i) {
            dp[0][i] = pizzas[i];
        }

        for (int i = 1; i <= k; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i == 1) {
                    dp[i][j] = max(dp[i][j - 1], pizzas[j]);
                } else {
                    dp[i][j] = max(dp[i][j - 1], dp[i - 1][j - 1] + pizzas[j]);
                }
            }
        }

        return dp[k][n - 1];
    }
};