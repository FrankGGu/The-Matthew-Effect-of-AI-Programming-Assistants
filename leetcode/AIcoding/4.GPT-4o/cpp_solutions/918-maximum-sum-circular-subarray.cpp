class Solution {
public:
    int maxSubarraySumCircular(vector<int>& nums) {
        int maxKadane = nums[0], minKadane = nums[0], total = nums[0];
        int currentMax = nums[0], currentMin = nums[0];

        for (int i = 1; i < nums.size(); i++) {
            currentMax = max(nums[i], currentMax + nums[i]);
            maxKadane = max(maxKadane, currentMax);

            currentMin = min(nums[i], currentMin + nums[i]);
            minKadane = min(minKadane, currentMin);

            total += nums[i];
        }

        if (total == minKadane) return maxKadane;
        return max(maxKadane, total - minKadane);
    }
};