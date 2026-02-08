class Solution {
public:
    int minSumOfLengths(vector<int>& arr, int target) {
        int n = arr.size();
        vector<int> dp(n + 1, INT_MAX);
        unordered_map<int, int> prefixSum;
        prefixSum[0] = -1;
        int currentSum = 0, result = INT_MAX;

        for (int i = 0; i < n; ++i) {
            currentSum += arr[i];
            if (prefixSum.count(currentSum - target)) {
                int startIdx = prefixSum[currentSum - target];
                int length = i - startIdx;
                if (startIdx >= 0) {
                    result = min(result, length + dp[startIdx + 1]);
                }
            }
            dp[i + 1] = min(dp[i], currentSum == target ? i + 1 : INT_MAX);
            prefixSum[currentSum] = i;
        }

        return result == INT_MAX ? -1 : result;
    }
};