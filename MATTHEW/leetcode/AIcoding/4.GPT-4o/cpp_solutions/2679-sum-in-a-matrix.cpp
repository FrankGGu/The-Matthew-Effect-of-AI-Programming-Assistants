class Solution {
public:
    int matrixSum(vector<vector<int>>& nums) {
        for (auto& row : nums) {
            sort(row.rbegin(), row.rend());
        }
        int sum = 0;
        for (int j = 0; j < nums[0].size(); ++j) {
            int maxVal = 0;
            for (int i = 0; i < nums.size(); ++i) {
                maxVal = max(maxVal, nums[i][j]);
            }
            sum += maxVal;
        }
        return sum;
    }
};