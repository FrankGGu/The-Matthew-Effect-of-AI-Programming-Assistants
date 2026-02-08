#include <vector>

using namespace std;

class Solution {
public:
    int idealArrays(int n, int maxValue) {
        int MOD = 1e9 + 7;
        vector<vector<long long>> dp(maxValue + 1, vector<long long>(n + 1, 0));
        vector<vector<long long>> C(n + maxValue, vector<long long>(n + 1, 0));

        for (int i = 0; i < n + maxValue; ++i) {
            C[i][0] = 1;
            for (int j = 1; j <= min(i, n); ++j) {
                C[i][j] = (C[i - 1][j - 1] + C[i - 1][j]) % MOD;
            }
        }

        for (int i = 1; i <= maxValue; ++i) {
            dp[i][1] = 1;
        }

        for (int j = 2; j <= n; ++j) {
            for (int i = 1; i <= maxValue; ++i) {
                for (int k = 2 * i; k <= maxValue; k += i) {
                    dp[k][j] = (dp[k][j] + dp[i][j - 1]) % MOD;
                }
            }
        }

        long long result = 0;
        for (int i = 1; i <= maxValue; ++i) {
            result = (result + dp[i][n]) % MOD;
        }

        vector<vector<long long>> count(maxValue + 1, vector<long long>(n + 1, 0));
        for (int i = 1; i <= maxValue; ++i) {
            count[i][1] = 1;
        }

        for (int len = 2; len <= n; ++len) {
            for (int last = 1; last <= maxValue; ++last) {
                for (int prev = 1; prev * prev <= last; ++prev) {
                    if (last % prev == 0) {
                        int other = last / prev;
                        if (prev != last) {
                            count[last][len] = (count[last][len] + count[prev][len - 1]) % MOD;
                        }
                        if (other != last && other != prev)
                            count[last][len] = (count[last][len] + count[other][len - 1]) % MOD;
                        else if (other == prev && prev != last)
                            count[last][len] = (count[last][len] + count[other][len - 1]) % MOD;
                    }
                }
            }
        }

        result = 0;
        for (int i = 1; i <= maxValue; i++) {
            result = (result + count[i][n]) % MOD;
        }
        result = 0;
        for (int i = 1; i <= maxValue; i++) {
            result = (result + (C[n + maxValue - 1 - n][n - 1] * dp[i][n]) % MOD) % MOD;
        }

        result = 0;
        for (int first = 1; first <= maxValue; first++) {
            result = (result + C[n - 1][n - 1]) % MOD;
            result = (result + C[n + maxValue - 1 - n][n - 1] * dp[first][n]) % MOD;
        }

        long long ans = 0;
        for(int i=1; i<=maxValue; i++){
            ans = (ans + (C[n-1 + 1 -1][n-1]) * dp[i][n]) % MOD;
        }

        result = 0;
        for (int i = 1; i <= maxValue; ++i) {
            result = (result + (C[n - 1][n - 1] * dp[i][n]) % MOD) % MOD;
        }
        return result;
    }
};