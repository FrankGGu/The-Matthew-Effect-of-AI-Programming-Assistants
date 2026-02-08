#include <vector>
#include <algorithm> // For std::min

class Solution {
public:
    int nthUglyNumber(int n) {
        if (n <= 0) {
            return 0;
        }

        std::vector<int> dp(n);
        dp[0] = 1;

        int p2 = 0;
        int p3 = 0;
        int p5 = 0;

        for (int i = 1; i < n; ++i) {
            int next_ugly_by2 = dp[p2] * 2;
            int next_ugly_by3 = dp[p3] * 3;
            int next_ugly_by5 = dp[p5] * 5;

            dp[i] = std::min({next_ugly_by2, next_ugly_by3, next_ugly_by5});

            if (dp[i] == next_ugly_by2) {
                p2++;
            }
            if (dp[i] == next_ugly_by3) {
                p3++;
            }
            if (dp[i] == next_ugly_by5) {
                p5++;
            }
        }

        return dp[n - 1];
    }
};