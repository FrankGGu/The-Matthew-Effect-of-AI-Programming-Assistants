#include <iostream>
#include <vector>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    int longestSquareStreak(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        unordered_map<int, int> dp;
        int maxLen = 0;

        for (int num : nums) {
            int len = 1;
            if (dp.find(num * num) != dp.end()) {
                len = dp[num * num] + 1;
            }
            dp[num] = len;
            maxLen = max(maxLen, len);
        }

        return maxLen >= 2 ? maxLen : -1;
    }
};