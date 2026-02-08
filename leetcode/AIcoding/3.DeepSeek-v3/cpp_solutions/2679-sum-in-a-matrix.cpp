class Solution {
public:
    int matrixSum(vector<vector<int>>& nums) {
        for (auto& row : nums) {
            sort(row.begin(), row.end());
        }
        int res = 0;
        for (int j = 0; j < nums[0].size(); ++j) {
            int max_val = 0;
            for (int i = 0; i < nums.size(); ++i) {
                max_val = max(max_val, nums[i][j]);
            }
            res += max_val;
        }
        return res;
    }
};