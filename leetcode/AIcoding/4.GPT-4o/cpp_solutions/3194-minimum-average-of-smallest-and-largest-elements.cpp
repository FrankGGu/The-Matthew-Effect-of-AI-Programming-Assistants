class Solution {
public:
    double minimumAverage(vector<int>& nums) {
        int n = nums.size();
        if (n == 0) return 0.0;

        sort(nums.begin(), nums.end());
        return (nums[0] + nums[n - 1]) / 2.0;
    }
};