#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int minFallingPathSum(vector<vector<int>>& grid) {
        int n = grid.size();

        int prev_min1 = 0;
        int prev_min2 = 0;
        int prev_idx1 = -1;

        for (int i = 0; i < n; ++i) {
            int curr_min1 = INT_MAX;
            int curr_min2 = INT_MAX;
            int curr_idx1 = -1;

            for (int j = 0; j < n; ++j) {
                int sum = grid[i][j] + (j == prev_idx1 ? prev_min2 : prev_min1);

                if (sum < curr_min1) {
                    curr_min2 = curr_min1;
                    curr_min1 = sum;
                    curr_idx1 = j;
                } else if (sum < curr_min2) {
                    curr_min2 = sum;
                }
            }
            prev_min1 = curr_min1;
            prev_min2 = curr_min2;
            prev_idx1 = curr_idx1;
        }

        return prev_min1;
    }
};