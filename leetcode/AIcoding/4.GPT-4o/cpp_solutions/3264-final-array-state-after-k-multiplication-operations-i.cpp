class Solution {
public:
    vector<int> finalArray(vector<int>& nums, vector<vector<int>>& operations) {
        for (const auto& op : operations) {
            for (int i = op[0]; i <= op[1]; ++i) {
                nums[i] *= op[2];
            }
        }
        return nums;
    }
};