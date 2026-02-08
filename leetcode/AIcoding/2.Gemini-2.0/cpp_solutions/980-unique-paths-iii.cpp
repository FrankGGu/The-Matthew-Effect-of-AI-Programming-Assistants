#include <vector>

using namespace std;

class Solution {
public:
    int uniquePathsIII(vector<vector<int>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();
        int start_row, start_col;
        int empty_cells = 0;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (grid[i][j] == 1) {
                    start_row = i;
                    start_col = j;
                } else if (grid[i][j] == 0) {
                    empty_cells++;
                }
            }
        }

        int count = 0;
        vector<vector<bool>> visited(rows, vector<bool>(cols, false));

        function<void(int, int, int)> dfs = [&](int row, int col, int visited_count) {
            if (row < 0 || row >= rows || col < 0 || col >= cols || grid[row][col] == -1 || visited[row][col]) {
                return;
            }

            visited[row][col] = true;
            visited_count++;

            if (grid[row][col] == 2) {
                if (visited_count == empty_cells + 2) {
                    count++;
                }
                visited[row][col] = false;
                return;
            }

            dfs(row + 1, col, visited_count);
            dfs(row - 1, col, visited_count);
            dfs(row, col + 1, visited_count);
            dfs(row, col - 1, visited_count);

            visited[row][col] = false;
        };

        dfs(start_row, start_col, 0);
        return count;
    }
};