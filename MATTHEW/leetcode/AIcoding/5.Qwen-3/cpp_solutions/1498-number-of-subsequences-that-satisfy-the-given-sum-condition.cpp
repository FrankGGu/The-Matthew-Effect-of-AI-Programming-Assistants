#include <iostream>
#include <vector>
#include <algorithm>
#include <numeric>

using namespace std;

class Solution {
public:
    int countSubseqs(vector<int>& nums, int target) {
        const int MOD = 1e9 + 7;
        int n = nums.size();
        vector<long long> dp(target + 1, 0);
        for (int i = 0; i < n; ++i) {
            for (int j = target; j >= nums[i]; --j) {
                dp[j] = (dp[j] + dp[j - nums[i]]) % MOD;
            }
            dp[nums[i]] = (dp[nums[i]] + 1) % MOD;
        }
        return dp[target];
    }
};