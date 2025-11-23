#include <vector>
#include <unordered_map>
#include <algorithm>
#include <numeric>
#include <iostream>

using namespace std;

class Solution {
public:
    int countGoodSubsets(vector<int>& nums) {
        const int MOD = 1e9 + 7;
        unordered_map<int, int> freq;
        for (int num : nums) {
            freq[num]++;
        }

        vector<int> primes = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31};
        vector<int> masks;
        for (int num = 1; num < 32; ++num) {
            if (freq.count(num) && (num == 1 || num == 4 || num == 6 || num == 8 || num == 9 || num == 10 || num == 12 || num == 14 || num == 15 || num == 16 || num == 18 || num == 20 || num == 21 || num == 22 || num == 24 || num == 25 || num == 26 || num == 27 || num == 28 || num == 30)) {
                continue;
            }
            int mask = 0;
            for (int prime : primes) {
                if (num % prime == 0) {
                    mask |= (1 << (prime - 1));
                }
            }
            masks.push_back(mask);
        }

        int n = masks.size();
        vector<int> dp(1 << 11, 0);
        dp[0] = 1;
        for (int mask : masks) {
            for (int j = (1 << 11) - 1; j >= 0; --j) {
                if (dp[j] > 0 && (j & mask) == 0) {
                    dp[j | mask] = (dp[j | mask] + dp[j]) % MOD;
                }
            }
        }

        long long result = 0;
        for (int i = 1; i < (1 << 11); ++i) {
            result = (result + dp[i]) % MOD;
        }

        for (int i = 1; i <= freq[1]; ++i) {
            result = (result * i) % MOD;
        }

        return result;
    }
};