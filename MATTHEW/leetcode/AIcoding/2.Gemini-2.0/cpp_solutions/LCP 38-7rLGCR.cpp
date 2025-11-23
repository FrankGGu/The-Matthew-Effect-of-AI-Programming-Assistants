#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int guardCastle(vector<string>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        int guards = 0;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == '.') {
                    bool canPlace = true;

                    // Check if placing a guard here blocks any walls
                    // Check left
                    for (int k = j - 1; k >= 0; --k) {
                        if (grid[i][k] == 'W') break;
                        if (grid[i][k] == 'G') {
                            canPlace = false;
                            break;
                        }
                    }
                    if (!canPlace) continue;

                    // Check right
                    for (int k = j + 1; k < n; ++k) {
                        if (grid[i][k] == 'W') break;
                        if (grid[i][k] == 'G') {
                            canPlace = false;
                            break;
                        }
                    }
                    if (!canPlace) continue;

                    // Check up
                    for (int k = i - 1; k >= 0; --k) {
                        if (grid[k][j] == 'W') break;
                        if (grid[k][j] == 'G') {
                            canPlace = false;
                            break;
                        }
                    }
                    if (!canPlace) continue;

                    // Check down
                    for (int k = i + 1; k < m; ++k) {
                        if (grid[k][j] == 'W') break;
                        if (grid[k][j] == 'G') {
                            canPlace = false;
                            break;
                        }
                    }
                    if (!canPlace) continue;

                    guards++;
                    grid[i][j] = 'G';
                }
            }
        }

        return guards;
    }
};