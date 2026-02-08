#include <vector>
#include <cmath>

class Solution {
public:
    std::vector<double> dicesProbability(int n) {
        std::vector<double> dp(6, 1.0);
        for (int i = 2; i <= n; ++i) {
            std::vector<double> temp(5 * i + 1, 0.0);
            for (int j = 0; j < dp.size(); ++j) {
                for (int k = 1; k <= 6; ++k) {
                    temp[j + k - 1] += dp[j];
                }
            }
            dp = temp;
        }

        double total = std::pow(6.0, n);
        for (double& val : dp) {
            val /= total;
        }

        return dp;
    }
};