class Solution {
public:
    int rows, cols;
    int ans = 0;
    int dr[4] = {-1, 1, 0, 0};
    int dc[4] = {0, 0, -1, 1};

    void dfs(std::vector<std::vector<int>>& grid, int r, int c, int steps_taken, int total_empty_squares) {
        if (r < 0 || r >= rows || c < 0 || c >= cols || grid[r][c] == -1) {
            return;
        }

        if (grid[r][c] == 2) {
            if (steps_taken == total_empty_squares) {
                ans++;
            }
            return;
        }

        int original_val = grid[r][c];
        grid[r][c] = -1; 

        for (int i = 0; i < 4; ++i) {
            int nr = r + dr[i];
            int nc = c + dc[i];
            dfs(grid, nr, nc, steps_taken + 1, total_empty_squares);
        }

        grid[r][c] = original_val;
    }

    int uniquePathsIII(std::vector<std::vector<int>>& grid) {
        rows = grid.size();
        cols = grid[0].size();

        int start_r, start_c;
        int empty_squares_count = 0;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (grid[i][j] == 1) {
                    start_r = i;
                    start_c = j;
                } else if (grid[i][j] == 0) {
                    empty_squares_count++;
                }
            }
        }

        dfs(grid, start_r, start_c, 0, empty_squares_count + 1);

        return ans;
    }
};