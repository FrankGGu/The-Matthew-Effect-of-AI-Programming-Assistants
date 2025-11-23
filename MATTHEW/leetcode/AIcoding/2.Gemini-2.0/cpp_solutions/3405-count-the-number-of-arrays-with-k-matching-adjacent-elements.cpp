#include <vector>

using namespace std;

class Solution {
public:
    int numberOfArrays(int n, int k, int x) {
        if (k == 0) {
            if (n == 1) return 1;
            else return 0;
        }

        if (n == 1) return 0;

        long long mod = 1e9 + 7;
        vector<vector<long long>> dp(n, vector<long long>(2, 0));
        dp[0][0] = 1;
        dp[0][1] = 0;

        for (int i = 1; i < n; ++i) {
            dp[i][0] = (dp[i - 1][1]) % mod;
            dp[i][1] = ((dp[i - 1][0] * (x - 1)) % mod + (dp[i - 1][1] * (x - 2)) % mod) % mod;
            if (dp[i][1] < 0) dp[i][1] += mod;
        }

        return dp[n - 1][0];
    }
};