class Solution {
public:
    int minimumCost(vector<int>& nums) {
        int n = nums.size();
        if (n < 3) return 0;
        int first = nums[0];
        nums.erase(nums.begin());
        sort(nums.begin(), nums.end());
        return first + nums[0] + nums[1];
    }
};