class Solution {
public:
    int longestSubsequence(vector<int>& arr, int difference) {
        unordered_map<int, int> dp;
        int max_len = 0;
        for (int num : arr) {
            dp[num] = dp[num - difference] + 1;
            max_len = max(max_len, dp[num]);
        }
        return max_len;
    }
};