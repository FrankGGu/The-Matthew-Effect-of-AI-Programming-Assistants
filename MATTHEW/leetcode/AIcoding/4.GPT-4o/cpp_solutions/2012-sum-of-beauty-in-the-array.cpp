class Solution {
public:
    long long sumOfBeauty(vector<int>& nums) {
        long long totalBeauty = 0;
        int n = nums.size();

        for (int i = 1; i < n - 1; ++i) {
            int leftMax = max(nums[i - 1], nums[i]);
            int rightMax = max(nums[i], nums[i + 1]);
            if (nums[i] > leftMax && nums[i] > rightMax) {
                totalBeauty += 2;
            } else if (nums[i] < leftMax && nums[i] < rightMax) {
                totalBeauty += 0;
            } else {
                totalBeauty += 1;
            }
        }

        return totalBeauty;
    }
};