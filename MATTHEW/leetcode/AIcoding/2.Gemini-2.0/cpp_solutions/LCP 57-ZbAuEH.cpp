#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maxKilledEnemies(vector<vector<char>>& grid) {
        if (grid.empty() || grid[0].empty()) {
            return 0;
        }

        int rows = grid.size();
        int cols = grid[0].size();
        int maxEnemies = 0;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (grid[i][j] == '0') {
                    int enemies = 0;

                    // Check left
                    for (int k = j - 1; k >= 0 && grid[i][k] != 'W'; --k) {
                        if (grid[i][k] == 'E') {
                            enemies++;
                        }
                    }

                    // Check right
                    for (int k = j + 1; k < cols && grid[i][k] != 'W'; ++k) {
                        if (grid[i][k] == 'E') {
                            enemies++;
                        }
                    }

                    // Check up
                    for (int k = i - 1; k >= 0 && grid[k][j] != 'W'; --k) {
                        if (grid[k][j] == 'E') {
                            enemies++;
                        }
                    }

                    // Check down
                    for (int k = i + 1; k < rows && grid[k][j] != 'W'; ++k) {
                        if (grid[k][j] == 'E') {
                            enemies++;
                        }
                    }

                    maxEnemies = max(maxEnemies, enemies);
                }
            }
        }

        return maxEnemies;
    }
};