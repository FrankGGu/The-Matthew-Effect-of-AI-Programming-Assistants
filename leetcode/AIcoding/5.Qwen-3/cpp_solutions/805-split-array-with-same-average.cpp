#include <iostream>
#include <vector>
#include <algorithm>
#include <unordered_set>

using namespace std;

class Solution {
public:
    bool splitArray(vector<int>& nums) {
        int n = nums.size();
        if (n < 2) return false;
        int total = 0;
        for (int num : nums) total += num;

        vector<int> dp(n + 1, 0);
        dp[0] = 1;

        for (int i = 0; i < n; ++i) {
            for (int j = i; j >= 1; --j) {
                int sum = 0;
                for (int k = i - j + 1; k <= i; ++k) {
                    sum += nums[k];
                }
                if (dp[j - 1] && total * j == sum * n) {
                    return true;
                }
                dp[j] |= dp[j - 1] << nums[i];
            }
        }

        return false;
    }
};