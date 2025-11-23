#include <vector>
#include <algorithm>
#include <limits>

using namespace std;

class Solution {
public:
    int minDifference(vector<vector<int>>& grid, int x) {
        int n = grid.size();
        int m = grid[0].size();
        int minDiff = numeric_limits<int>::max();

        for (int i = 0; i < n - 1; ++i) {
            for (int j = 0; j < m - 1; ++j) {
                vector<int> nums;
                nums.push_back(grid[i][j]);
                nums.push_back(grid[i + 1][j]);
                nums.push_back(grid[i][j + 1]);
                nums.push_back(grid[i + 1][j + 1]);

                sort(nums.begin(), nums.end());

                for (int k = 0; k < 4; ++k) {
                    for (int l = k + 1; l < 4; ++l) {
                        if (abs(nums[k] - nums[l]) <= x) {
                            minDiff = min(minDiff, abs(nums[k] - nums[l]));
                        }
                    }
                }
            }
        }

        if(minDiff == numeric_limits<int>::max()){
            return -1;
        }

        return minDiff;
    }
};