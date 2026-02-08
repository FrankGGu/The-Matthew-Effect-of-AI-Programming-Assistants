#include <vector>

using namespace std;

class Solution {
public:
    int numberOfGoodSubsets(vector<int>& nums) {
        int MOD = 1e9 + 7;
        vector<int> primes = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29};
        vector<int> mask(31, 0);
        for (int i = 0; i < primes.size(); ++i) {
            mask[primes[i]] = 1 << i;
        }

        vector<long long> dp(1 << 10, 0);
        dp[0] = 1;
        int ones = 0;
        for (int num : nums) {
            if (num == 1) {
                ones++;
                continue;
            }
            if (mask[num] == 0) continue;

            int m = mask[num];
            for (int i = (1 << 10) - 1; i >= 0; --i) {
                if ((i & m) == 0) {
                    dp[i | m] = (dp[i | m] + dp[i]) % MOD;
                }
            }
        }

        long long ans = 0;
        for (int i = 1; i < (1 << 10); ++i) {
            ans = (ans + dp[i]) % MOD;
        }

        long long powerOfTwo = 1;
        for (int i = 0; i < ones; ++i) {
            powerOfTwo = (powerOfTwo * 2) % MOD;
        }

        return (ans * powerOfTwo) % MOD;
    }
};