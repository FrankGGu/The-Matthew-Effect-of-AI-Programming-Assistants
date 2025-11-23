class Solution {
public:
    int countSubarrays(vector<int>& nums) {
        int n = nums.size();
        int maxCount = 0;
        int currentCount = 0;

        for (int i = 0; i < n; ++i) {
            if (i == 0 || nums[i] >= nums[i - 1]) {
                currentCount++;
            } else {
                currentCount = 1;
            }
            maxCount += currentCount;
        }

        currentCount = 0;

        for (int i = n - 1; i >= 0; --i) {
            if (i == n - 1 || nums[i] >= nums[i + 1]) {
                currentCount++;
            } else {
                currentCount = 1;
            }
            maxCount += currentCount;
        }

        return maxCount - n;
    }
};