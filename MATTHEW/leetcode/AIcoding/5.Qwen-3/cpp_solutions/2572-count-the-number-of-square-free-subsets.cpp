#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int squareFreeSubsets(vector<int>& nums) {
        const int MOD = 1e9 + 7;
        vector<int> primes = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31};
        unordered_map<int, int> dp;
        dp[0] = 1;

        for (int num : nums) {
            if (num == 0) continue;
            int mask = 0;
            bool valid = true;
            for (int i = 0; i < primes.size(); ++i) {
                int p = primes[i];
                if (num % (p * p) == 0) {
                    valid = false;
                    break;
                }
                if (num % p == 0) {
                    mask |= (1 << i);
                }
            }
            if (!valid) continue;

            vector<pair<int, int>> temp(dp.begin(), dp.end());
            for (auto& [prev_mask, count] : temp) {
                if ((prev_mask & mask) == 0) {
                    dp[prev_mask | mask] = (dp[prev_mask | mask] + count) % MOD;
                }
            }
        }

        int result = 0;
        for (auto& [mask, count] : dp) {
            result = (result + count) % MOD;
        }
        return result;
    }
};