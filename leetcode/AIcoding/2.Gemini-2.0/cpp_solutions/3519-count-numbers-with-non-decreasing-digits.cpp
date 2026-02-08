#include <vector>

using namespace std;

class Solution {
public:
    int countNumbersWithUniqueDigits(int n) {
        if (n == 0) {
            return 1;
        }
        if (n > 10) {
            n = 10;
        }

        vector<int> dp(n + 1, 0);
        dp[0] = 1;
        dp[1] = 9;

        int availableDigits = 9;
        int result = 10;

        for (int i = 2; i <= n; ++i) {
            dp[i] = dp[i - 1] * availableDigits;
            result += dp[i];
            availableDigits--;
        }

        return result;
    }

    int countNumbersWithNonDecreasingDigits(int n) {
        vector<vector<int>> dp(n + 1, vector<int>(10, 0));

        for (int i = 0; i < 10; ++i) {
            dp[1][i] = 1;
        }

        for (int i = 2; i <= n; ++i) {
            for (int j = 0; j < 10; ++j) {
                for (int k = 0; k <= j; ++k) {
                    dp[i][j] += dp[i - 1][k];
                }
            }
        }

        int result = 0;
        for (int i = 0; i < 10; ++i) {
            result += dp[n][i];
        }

        return result;
    }
};