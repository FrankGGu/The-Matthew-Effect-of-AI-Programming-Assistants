#include <vector>
#include <unordered_map>
#include <algorithm>

class Solution {
public:
    int longestSubsequence(std::vector<int>& arr, int difference) {
        std::unordered_map<int, int> dp;
        int maxLength = 0;

        for (int num : arr) {
            dp[num] = 1 + dp[num - difference];
            maxLength = std::max(maxLength, dp[num]);
        }

        return maxLength;
    }
};