class Solution {
public:
    long long sumOfKSubarrays(vector<int>& nums, int k, int m) {
        int n = nums.size();
        long long result = 0;
        vector<long long> prefixSum(n + 1, 0);

        for (int i = 0; i < n; ++i) {
            prefixSum[i + 1] = prefixSum[i] + nums[i];
        }

        for (int length = m; length <= n; ++length) {
            for (int start = 0; start + length <= n; ++start) {
                result += prefixSum[start + length] - prefixSum[start];
            }
        }

        return result;
    }
};