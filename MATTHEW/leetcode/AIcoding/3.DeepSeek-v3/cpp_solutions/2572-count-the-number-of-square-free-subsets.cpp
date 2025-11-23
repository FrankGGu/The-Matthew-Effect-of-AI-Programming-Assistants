#include <vector>
#include <unordered_map>
using namespace std;

class Solution {
public:
    int squareFreeSubsets(vector<int>& nums) {
        const int MOD = 1e9 + 7;
        vector<int> primes = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29};
        int n = primes.size();
        vector<int> masks(nums.size(), 0);

        for (int i = 0; i < nums.size(); ++i) {
            int num = nums[i];
            int mask = 0;
            bool valid = true;
            for (int j = 0; j < n; ++j) {
                int p = primes[j];
                if (num % (p * p) == 0) {
                    valid = false;
                    break;
                }
                if (num % p == 0) {
                    mask |= (1 << j);
                }
            }
            if (valid) {
                masks[i] = mask;
            } else {
                masks[i] = -1;
            }
        }

        unordered_map<int, int> dp;
        dp[0] = 1;

        for (int i = 0; i < nums.size(); ++i) {
            if (masks[i] == -1) continue;
            unordered_map<int, int> new_dp = dp;
            for (auto& [mask, cnt] : dp) {
                if ((mask & masks[i]) == 0) {
                    int new_mask = mask | masks[i];
                    new_dp[new_mask] = (new_dp[new_mask] + cnt) % MOD;
                }
            }
            dp = new_dp;
        }

        long long res = 0;
        for (auto& [mask, cnt] : dp) {
            res = (res + cnt) % MOD;
        }
        return (res - 1 + MOD) % MOD;
    }
};