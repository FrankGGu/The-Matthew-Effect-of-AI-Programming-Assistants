#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumOperationsToMakeEqual(int x, int y) {
        if (x <= y) {
            return y - x;
        }

        int dp[x + 1];
        for (int i = 0; i <= x; ++i) {
            dp[i] = x - i;
        }

        for (int i = x - 1; i >= y; --i) {
            dp[i] = dp[i + 1] + 1;
            if (i % 5 == 0) {
                dp[i] = min(dp[i], dp[i / 5] + 1);
            } else {
                int next5 = (i / 5 + 1) * 5;
                int prev5 = (i / 5) * 5;
                dp[i] = min(dp[i], dp[next5] + next5 - i + 1);
                dp[i] = min(dp[i], dp[prev5] + i - prev5 + 1);
            }

            if (i % 11 == 0) {
                dp[i] = min(dp[i], dp[i / 11] + 1);
            } else {
                int next11 = (i / 11 + 1) * 11;
                int prev11 = (i / 11) * 11;
                dp[i] = min(dp[i], dp[next11] + next11 - i + 1);
                dp[i] = min(dp[i], dp[prev11] + i - prev11 + 1);
            }
        }

        return dp[y];
    }
};