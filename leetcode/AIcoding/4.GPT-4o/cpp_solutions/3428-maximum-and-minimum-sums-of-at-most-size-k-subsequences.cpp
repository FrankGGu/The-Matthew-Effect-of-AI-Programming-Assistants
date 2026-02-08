class Solution {
public:
    long long maximumSum(vector<int>& nums, int k) {
        sort(nums.rbegin(), nums.rend());
        long long maxSum = 0;
        for (int i = 0; i < k; i++) {
            maxSum += nums[i];
        }
        return maxSum;
    }

    long long minimumSum(vector<int>& nums, int k) {
        sort(nums.begin(), nums.end());
        long long minSum = 0;
        for (int i = 0; i < k; i++) {
            minSum += nums[i];
        }
        return minSum;
    }

    vector<long long> maximumAndMinimumSums(vector<int>& nums, int k) {
        return {maximumSum(nums, k), minimumSum(nums, k)};
    }
};