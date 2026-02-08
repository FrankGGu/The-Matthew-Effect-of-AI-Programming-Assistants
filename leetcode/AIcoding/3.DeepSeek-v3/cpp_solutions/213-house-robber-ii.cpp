class Solution {
public:
    int rob(vector<int>& nums) {
        int n = nums.size();
        if (n == 1) return nums[0];
        return max(robRange(nums, 0, n - 2), robRange(nums, 1, n - 1));
    }

private:
    int robRange(vector<int>& nums, int start, int end) {
        if (start > end) return 0;
        int prevMax = 0, currMax = 0;
        for (int i = start; i <= end; i++) {
            int temp = currMax;
            currMax = max(prevMax + nums[i], currMax);
            prevMax = temp;
        }
        return currMax;
    }
};