class Solution {
public:
    int largestOutlier(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        int n = nums.size();
        if (n < 3) return nums[0]; 

        if ((nums[1] - nums[0]) > (nums[n-1] - nums[n-2])) {
            return nums[0];
        } else {
            return nums[n-1];
        }
    }
};