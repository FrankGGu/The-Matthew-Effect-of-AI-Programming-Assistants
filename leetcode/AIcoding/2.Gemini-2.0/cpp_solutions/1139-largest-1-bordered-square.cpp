#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int largest1BorderedSquare(vector<vector<int>>& grid) {
        int n = grid.size();
        int m = grid[0].size();
        int max_side = 0;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < m; ++j) {
                if (grid[i][j] == 1) {
                    max_side = max(max_side, 1);
                    for (int k = 2; i + k - 1 < n && j + k - 1 < m; ++k) {
                        bool valid = true;
                        for (int l = 0; l < k; ++l) {
                            if (grid[i][j + l] == 0 || grid[i + k - 1][j + l] == 0 || grid[i + l][j] == 0 || grid[i + l][j + k - 1] == 0) {
                                valid = false;
                                break;
                            }
                        }
                        if (valid) {
                            max_side = max(max_side, k);
                        } else {
                            break;
                        }
                    }
                }
            }
        }

        return max_side * max_side;
    }
};