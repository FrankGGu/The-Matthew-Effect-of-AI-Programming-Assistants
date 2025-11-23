#include <string>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int print(int n) {
        if (n <= 4) {
            return n;
        }

        vector<int> dp(n + 1, 0);
        for (int i = 1; i <= 4; ++i) {
            dp[i] = i;
        }

        for (int i = 5; i <= n; ++i) {
            dp[i] = i;
            for (int j = 3; j < i; ++j) {
                dp[i] = max(dp[i], dp[i - j] * (j - 1));
            }
        }

        return dp[n];
    }
};