class Solution {
public:
    int minOperations(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        vector<int> nums;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                nums.push_back(grid[i][j]);
            }
        }
        sort(nums.begin(), nums.end());
        int median = nums[nums.size() / 2];
        int ops = 0;
        for (const int& num : nums) {
            ops += abs(num - median);
        }
        return ops;
    }
};