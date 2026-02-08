#include <vector>

using namespace std;

class Solution {
public:
    int countUnguarded(int m, int n, vector<vector<int>>& guards, vector<vector<int>>& walls) {
        vector<vector<int>> grid(m, vector<int>(n, 0));

        for (auto& wall : walls) {
            grid[wall[0]][wall[1]] = 2;
        }

        for (auto& guard : guards) {
            grid[guard[0]][guard[1]] = 1;
        }

        for (auto& guard : guards) {
            int row = guard[0];
            int col = guard[1];

            // Right
            for (int j = col + 1; j < n; ++j) {
                if (grid[row][j] == 1 || grid[row][j] == 2) {
                    break;
                }
                grid[row][j] = -1;
            }

            // Left
            for (int j = col - 1; j >= 0; --j) {
                if (grid[row][j] == 1 || grid[row][j] == 2) {
                    break;
                }
                grid[row][j] = -1;
            }

            // Down
            for (int i = row + 1; i < m; ++i) {
                if (grid[i][col] == 1 || grid[i][col] == 2) {
                    break;
                }
                grid[i][col] = -1;
            }

            // Up
            for (int i = row - 1; i >= 0; --i) {
                if (grid[i][col] == 1 || grid[i][col] == 2) {
                    break;
                }
                grid[i][col] = -1;
            }
        }

        int unguarded = 0;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 0) {
                    unguarded++;
                }
            }
        }

        return unguarded;
    }
};