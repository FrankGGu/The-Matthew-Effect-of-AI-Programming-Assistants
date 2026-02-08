#include <iostream>
#include <vector>
#include <unordered_map>

using namespace std;

class Solution {
public:
    int longestSubsequence(int n, int difference, vector<int>& arr) {
        unordered_map<int, int> dp;
        int result = 0;
        for (int num : arr) {
            int prev = num - difference;
            int count = dp[prev] + 1;
            dp[num] = max(dp[num], count);
            result = max(result, dp[num]);
        }
        return result;
    }
};