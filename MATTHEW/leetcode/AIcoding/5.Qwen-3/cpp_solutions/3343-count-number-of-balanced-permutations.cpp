#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numBalancedPermutations(int n, vector<int>& counts) {
        vector<int> freq(10, 0);
        for (int c : counts) {
            freq[c]++;
        }

        vector<vector<long long>> dp(10, vector<long long>(n + 1, 0));
        dp[0][0] = 1;

        for (int i = 0; i < 10; ++i) {
            for (int j = 0; j <= n; ++j) {
                if (dp[i][j] == 0) continue;
                for (int k = 0; k <= min(n - j, freq[i]); ++k) {
                    if (j + k > n) break;
                    dp[i + 1][j + k] += dp[i][j] * (factorial(n - j) / (factorial(k) * factorial(n - j - k)));
                }
            }
        }

        return dp[10][n];
    }

private:
    long long factorial(int n) {
        long long res = 1;
        for (int i = 2; i <= n; ++i) {
            res *= i;
        }
        return res;
    }
};