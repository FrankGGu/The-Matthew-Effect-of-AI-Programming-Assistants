class Solution {
public:
    bool canBeSorted(vector<int>& nums) {
        vector<int> sorted_nums = nums;
        sort(sorted_nums.begin(), sorted_nums.end());
        return nums == sorted_nums;
    }
};