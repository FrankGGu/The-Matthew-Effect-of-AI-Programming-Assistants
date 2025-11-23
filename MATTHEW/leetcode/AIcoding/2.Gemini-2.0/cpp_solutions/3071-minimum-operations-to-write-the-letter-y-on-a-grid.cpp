#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumOperationsToWriteY(vector<vector<int>>& grid) {
        int n = grid.size();
        int ones = 0;
        int twos = 0;
        vector<int> y_ones;
        vector<int> y_twos;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if ((i == j && i <= n / 2) || (i + j == n - 1 && i <= n / 2) || (j == n / 2 && i > n / 2)) {
                    if (grid[i][j] == 0) {
                        ones++;
                    } else {
                        twos++;
                        y_twos.push_back(grid[i][j]);
                    }
                } else {
                    if (grid[i][j] == 1) {
                        twos++;
                    } else {
                        ones++;
                        y_ones.push_back(grid[i][j]);
                    }
                }
            }
        }

        return ones;
    }
};