#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> longestSubsequenceWithDecreasingAdjacentDifference(vector<int>& nums) {
        int n = nums.size();
        vector<int> dp(n, 1);
        vector<int> prev(n, -1);
        int maxLen = 1;
        int lastIndex = 0;

        for (int i = 1; i < n; ++i) {
            for (int j = 0; j < i; ++j) {
                if (nums[j] > nums[i] && dp[j] + 1 > dp[i]) {
                    dp[i] = dp[j] + 1;
                    prev[i] = j;
                }
            }
            if (dp[i] > maxLen) {
                maxLen = dp[i];
                lastIndex = i;
            }
        }

        vector<int> result(maxLen);
        int index = maxLen - 1;
        while (lastIndex != -1) {
            result[index--] = nums[lastIndex];
            lastIndex = prev[lastIndex];
        }

        return result;
    }
};