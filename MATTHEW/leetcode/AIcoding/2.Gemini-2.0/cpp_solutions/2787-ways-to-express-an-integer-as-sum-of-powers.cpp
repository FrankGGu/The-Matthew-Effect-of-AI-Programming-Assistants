#include <vector>

using namespace std;

class Solution {
public:
    int ways(int n, int x) {
        int mod = 1e9 + 7;
        vector<int> dp(n + 1, 0);
        dp[0] = 1;
        for (int i = 1; pow(i, x) <= n; ++i) {
            int p = pow(i, x);
            for (int j = p; j <= n; ++j) {
                dp[j] = (dp[j] + dp[j - p]) % mod;
            }
        }
        return dp[n];
    }
};