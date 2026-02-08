#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int nthSuperUglyNumber(int n, vector<int>& primes) {
        vector<int> dp(n, 1);
        vector<int> indices(primes.size(), 0);
        vector<int> next_vals(primes.size(), 1);

        for (int i = 1; i < n; ++i) {
            int min_val = INT_MAX;
            for (int j = 0; j < primes.size(); ++j) {
                if (next_vals[j] < min_val) {
                    min_val = next_vals[j];
                }
            }
            dp[i] = min_val;
            for (int j = 0; j < primes.size(); ++j) {
                if (next_vals[j] == min_val) {
                    indices[j]++;
                    next_vals[j] = dp[indices[j]] * primes[j];
                }
            }
        }
        return dp[n - 1];
    }
};