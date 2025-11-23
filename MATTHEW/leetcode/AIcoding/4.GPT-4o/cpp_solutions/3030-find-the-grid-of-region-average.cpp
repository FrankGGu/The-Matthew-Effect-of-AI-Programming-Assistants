#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    vector<vector<double>> regionAverages(vector<vector<int>>& grid) {
        int m = grid.size(), n = grid[0].size();
        vector<vector<double>> result(m, vector<double>(n, 0));

        vector<int> dir = {-1, 0, 1, 0, -1};

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                double sum = grid[i][j];
                int count = 1;

                for (int d = 0; d < 4; ++d) {
                    int ni = i + dir[d];
                    int nj = j + dir[d + 1];
                    if (ni >= 0 && ni < m && nj >= 0 && nj < n) {
                        sum += grid[ni][nj];
                        count++;
                    }
                }

                result[i][j] = sum / count;
            }
        }

        return result;
    }
};