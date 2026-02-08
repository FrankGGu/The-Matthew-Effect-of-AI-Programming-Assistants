class Solution {
public:
    int minimumSum(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        return (nums[0] + nums[1]) * 10 + (nums[2] + nums[3]);
    }
};