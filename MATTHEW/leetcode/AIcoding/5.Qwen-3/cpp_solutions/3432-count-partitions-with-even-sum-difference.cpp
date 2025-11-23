#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int countPartitions(vector<int>& nums, int k) {
        int n = nums.size();
        long long total = 0;
        for (int num : nums) {
            total += num;
        }

        vector<long long> dp(n + 1, 0);
        dp[0] = 1;

        for (int i = 0; i < n; ++i) {
            for (int j = n; j > 0; --j) {
                dp[j] += dp[j - 1];
            }
        }

        long long result = 0;
        for (int i = 0; i < n; ++i) {
            long long sum1 = 0;
            for (int j = 0; j <= i; ++j) {
                sum1 += nums[j];
            }
            long long sum2 = total - sum1;
            if (abs(sum1 - sum2) % 2 == 0) {
                result += dp[i + 1];
            }
        }

        return result;
    }
};