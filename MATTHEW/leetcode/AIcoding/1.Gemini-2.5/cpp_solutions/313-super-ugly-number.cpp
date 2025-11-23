#include <vector>
#include <algorithm>
#include <climits>

class Solution {
public:
    int nthSuperUglyNumber(int n, std::vector<int>& primes) {
        if (n == 0) {
            return 0;
        }
        if (n == 1) {
            return 1;
        }

        std::vector<int> dp(n);
        dp[0] = 1;

        std::vector<int> pointers(primes.size(), 0);

        for (int i = 1; i < n; ++i) {
            long long min_val = LLONG_MAX;

            for (int j = 0; j < primes.size(); ++j) {
                min_val = std::min(min_val, (long long)dp[pointers[j]] * primes[j]);
            }

            dp[i] = (int)min_val;

            for (int j = 0; j < primes.size(); ++j) {
                if ((long long)dp[pointers[j]] * primes[j] == min_val) {
                    pointers[j]++;
                }
            }
        }

        return dp[n - 1];
    }
};