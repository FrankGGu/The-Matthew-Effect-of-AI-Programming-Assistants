#include <vector>
#include <numeric>

class Solution {
public:
    int count = 0;
    std::vector<std::vector<int>> grid;
    std::vector<bool> used;

    void solve(int r, int c) {
        if (r == 3) {
            count++;
            return;
        }

        int next_r = r;
        int next_c = c + 1;
        if (next_c == 3) {
            next_r++;
            next_c = 0;
        }

        if (r == 1 && c == 1) {
            if (!used[5]) {
                grid[r][c] = 5;
                used[5] = true;
                solve(next_r, next_c);
                used[5] = false;
                grid[r][c] = 0;
            }
            return;
        }

        for (int num = 1; num <= 9; ++num) {
            if (!used[num]) {
                grid[r][c] = num;
                used[num] = true;

                bool possible = true;
                int target_sum = 15;

                if (c == 2) {
                    if (grid[r][0] + grid[r][1] + grid[r][2] != target_sum) {
                        possible = false;
                    }
                }
                if (r == 2) {
                    if (grid[0][c] + grid[1][c] + grid[2][c] != target_sum) {
                        possible = false;
                    }
                }
                if (r == 2 && c == 2) {
                    if (grid[0][0] + grid[1][1] + grid[2][2] != target_sum) {
                        possible = false;
                    }
                }
                if (r == 2 && c == 0) {
                    if (grid[0][2] + grid[1][1] + grid[2][0] != target_sum) {
                        possible = false;
                    }
                }

                if (possible) {
                    solve(next_r, next_c);
                }

                used[num] = false;
                grid[r][c] = 0;
            }
        }
    }

    int fillSpecialGrid() {
        grid.assign(3, std::vector<int>(3, 0));
        used.assign(10, false);

        solve(0, 0);
        return count;
    }
};