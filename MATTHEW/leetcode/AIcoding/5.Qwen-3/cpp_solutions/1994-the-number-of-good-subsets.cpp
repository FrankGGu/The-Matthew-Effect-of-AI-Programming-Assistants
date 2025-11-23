#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int numberOfGoodSubsets(vector<int>& nums) {
        const int MOD = 1e9 + 7;
        vector<int> freq(32, 0);
        for (int num : nums) {
            if (num == 1) continue;
            if (num >= 2 && num <= 31) {
                freq[num]++;
            }
        }

        vector<int> dp(1 << 16, 0);
        dp[0] = 1;

        for (int i = 2; i <= 31; ++i) {
            if (freq[i] == 0) continue;
            for (int mask = 0; mask < (1 << 16); ++mask) {
                if ((mask & (1 << (i - 2))) == 0) {
                    dp[mask | (1 << (i - 2))] = (dp[mask | (1 << (i - 2))] + dp[mask] * freq[i]) % MOD;
                }
            }
        }

        int result = 0;
        for (int mask = 1; mask < (1 << 16); ++mask) {
            result = (result + dp[mask]) % MOD;
        }

        return result;
    }
};