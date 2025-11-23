class Solution {
public:
    vector<int> findDiagonalOrder(vector<vector<int>>& nums) {
        map<int, vector<int>> groups;
        for (int row = nums.size() - 1; row >= 0; --row) {
            for (int col = 0; col < nums[row].size(); ++col) {
                int diagonal = row + col;
                groups[diagonal].push_back(nums[row][col]);
            }
        }

        vector<int> result;
        for (auto& [key, values] : groups) {
            for (int num : values) {
                result.push_back(num);
            }
        }
        return result;
    }
};