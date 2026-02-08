class Solution {
public:
    int maximumBalancedSum(vector<int>& nums) {
        int n = nums.size();
        vector<int> prefixSum(n + 1, 0);
        for (int i = 0; i < n; ++i) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        int maxSum = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (prefixSum[j + 1] - prefixSum[i] == 0) {
                    maxSum = max(maxSum, prefixSum[j + 1] - prefixSum[i]);
                }
            }
        }
        return maxSum;
    }
};