class Solution {
public:
    vector<vector<int>> permuteUnique(vector<int>& nums) {
        vector<vector<int>> res;
        sort(nums.begin(), nums.end());
        backtrack(nums, res, 0);
        return res;
    }

    void backtrack(vector<int> nums, vector<vector<int>>& res, int start) {
        if (start == nums.size()) {
            res.push_back(nums);
            return;
        }
        for (int i = start; i < nums.size(); ++i) {
            if (i != start && nums[i] == nums[start]) continue;
            swap(nums[start], nums[i]);
            backtrack(nums, res, start + 1);
        }
    }
};