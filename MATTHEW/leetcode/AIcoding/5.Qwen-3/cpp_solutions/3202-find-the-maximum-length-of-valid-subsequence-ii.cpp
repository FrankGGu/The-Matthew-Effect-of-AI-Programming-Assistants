#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int findMaximumLength(vector<int>& nums) {
        int n = nums.size();
        vector<int> dp(n, 1);
        vector<int> prev(n, -1);
        vector<int> max_len(n, 1);

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (nums[j] < nums[i] && dp[j] + 1 > dp[i]) {
                    dp[i] = dp[j] + 1;
                    prev[i] = j;
                }
            }
        }

        int max_length = 1;
        int end_index = 0;

        for (int i = 0; i < n; ++i) {
            if (dp[i] > max_length) {
                max_length = dp[i];
                end_index = i;
            }
        }

        return max_length;
    }
};