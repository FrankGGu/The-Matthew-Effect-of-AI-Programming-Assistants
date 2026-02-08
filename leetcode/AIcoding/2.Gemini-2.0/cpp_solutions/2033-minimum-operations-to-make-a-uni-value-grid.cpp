#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minOperations(vector<vector<int>>& grid, int x) {
        int m = grid.size();
        int n = grid[0].size();
        vector<int> nums;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                nums.push_back(grid[i][j]);
            }
        }

        sort(nums.begin(), nums.end());
        int median = nums[nums.size() / 2];

        int operations = 0;
        for (int num : nums) {
            int diff = abs(num - median);
            if (diff % x != 0) {
                return -1;
            }
            operations += diff / x;
        }

        return operations;
    }
};