#include <vector>
#include <string>

class Solution {
public:
    // Directions: 0: right, 1: down, 2: left, 3: up
    // dr: change in row, dc: change in column
    // (0,1) -> right
    // (1,0) -> down
    // (0,-1) -> left
    // (-1,0) -> up
    int dr[4] = {0, 1, 0, -1};
    int dc[4] = {1, 0, -1, 0};

    std::vector<int> solve(std::vector<std::string>& grid, int start_row, int start_col, int start_dir) {
        int m = grid.size();
        int n = grid[0].size();

        int curr_r = start_row;
        int curr_c = start_col;
        int curr_dir = start_dir;

        while (true) {
            int next_r = curr_r + dr[curr_dir];
            int next_c = curr_c + dc[curr_dir];

            if (next_r < 0 || next_r >= m || next_c < 0 || next_c >= n) {
                return {next_r, next_c};
            }

            curr_r = next_r;
            curr_c = next_c;

            if (grid[curr_r][curr_c] == '/') {
                curr_dir = 3 - curr_dir;
            } else if (grid[curr_r][curr_c] == '\\') {
                curr_dir = curr_dir ^ 1;
            }
        }
    }
};