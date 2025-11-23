#include <iostream>
#include <vector>
#include <cmath>

using namespace std;

class Solution {
public:
    int waysToMakeArray(vector<int>& nums) {
        int MOD = 1e9 + 7;
        int n = nums.size();
        vector<int> factors;

        for (int num : nums) {
            int x = num;
            for (int i = 2; i * i <= x; ++i) {
                while (x % i == 0) {
                    factors.push_back(i);
                    x /= i;
                }
            }
            if (x > 1) {
                factors.push_back(x);
            }
        }

        int m = factors.size();
        vector<long long> dp(m + 1, 0);
        dp[0] = 1;

        for (int i = 1; i <= m; ++i) {
            dp[i] = (dp[i - 1] * 2) % MOD;
        }

        return (dp[m] - 1) % MOD;
    }
};