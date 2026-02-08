#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int lengthOfLIS(vector<int>& nums, int k) {
        vector<int> dp;
        vector<int> max_val;

        for (int num : nums) {
            int idx = lower_bound(dp.begin(), dp.end(), num) - dp.begin();
            if (idx == 0) {
                if (dp.empty() || num > dp[0]) {
                    dp.insert(dp.begin(), num);
                    max_val.insert(max_val.begin(), 1);
                }
            } else {
                int prev_len = max_val[idx - 1];
                if (idx < dp.size() && num <= dp[idx]) {
                    dp[idx] = num;
                    max_val[idx] = prev_len + 1;
                } else {
                    dp.insert(dp.begin() + idx, num);
                    max_val.insert(max_val.begin() + idx, prev_len + 1);
                }
            }
        }

        return max_val.back();
    }
};