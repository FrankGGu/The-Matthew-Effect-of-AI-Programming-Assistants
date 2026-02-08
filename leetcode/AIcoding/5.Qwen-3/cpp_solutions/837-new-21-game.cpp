#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    double new21Game(int N, int K) {
        vector<double> dp(K + N + 1, 0.0);
        dp[K] = 1.0;
        for (int i = K - 1; i >= 0; --i) {
            dp[i] = dp[i + 1];
            if (i + 21 <= K) {
                dp[i] -= dp[i + 21];
            }
        }
        for (int i = 1; i <= N; ++i) {
            dp[i] += dp[i - 1];
        }
        return dp[N];
    }
};