class Solution {
public:
    long long sumOfSubarrayValues(vector<int>& nums) {
        long long totalSum = 0;
        int n = nums.size();
        for (int i = 0; i < n; ++i) {
            long long contribution = static_cast<long long>(nums[i]) * (i + 1) * (n - i);
            totalSum += contribution;
        }
        return totalSum;
    }
};