#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int eatPizzas(vector<int>& pizzaSlices) {
        int n = pizzaSlices.size();
        if (n == 0) return 0;

        vector<int> dp(n + 1, 0);
        dp[0] = 0;
        dp[1] = pizzaSlices[0];

        for (int i = 2; i <= n; ++i) {
            dp[i] = max(dp[i - 1], dp[i - 2] + pizzaSlices[i - 1]);
        }

        return dp[n];
    }
};