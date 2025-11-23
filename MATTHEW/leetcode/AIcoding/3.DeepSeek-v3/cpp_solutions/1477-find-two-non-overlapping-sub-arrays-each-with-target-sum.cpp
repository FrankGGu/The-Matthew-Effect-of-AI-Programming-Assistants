class Solution {
public:
    int minSumOfLengths(vector<int>& arr, int target) {
        int n = arr.size();
        vector<int> dp(n, INT_MAX);
        int sum = 0;
        int res = INT_MAX;
        int min_len = INT_MAX;
        unordered_map<int, int> prefix;
        prefix[0] = -1;

        for (int i = 0; i < n; ++i) {
            sum += arr[i];
            prefix[sum] = i;
        }

        sum = 0;
        for (int i = 0; i < n; ++i) {
            sum += arr[i];
            if (prefix.find(sum - target) != prefix.end()) {
                int prev = prefix[sum - target];
                if (prev >= 0 && dp[prev] != INT_MAX) {
                    res = min(res, dp[prev] + i - prev);
                }
                min_len = min(min_len, i - prev);
            }
            dp[i] = min_len;
        }

        return res == INT_MAX ? -1 : res;
    }
};