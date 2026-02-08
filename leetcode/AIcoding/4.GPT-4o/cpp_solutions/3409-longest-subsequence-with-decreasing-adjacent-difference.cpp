class Solution {
public:
    int longestSubsequence(vector<int>& arr, int difference) {
        unordered_map<int, int> dp;
        int maxLength = 0;

        for (int num : arr) {
            dp[num] = dp[num - difference] + 1;
            maxLength = max(maxLength, dp[num]);
        }

        return maxLength;
    }
};