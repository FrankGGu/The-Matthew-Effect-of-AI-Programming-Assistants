#include <vector>
#include <utility> // For std::pair

class Solution {
public:
    int R, C;
    int originalColor;
    std::vector<std::vector<bool>> visited;
    std::vector<std::pair<int, int>> borderCells;
    int dr[4] = {-1, 1, 0, 0};
    int dc[4] = {0, 0, -1, 1};

    void dfs(int r, int c, const std::vector<std::vector<int>>& grid) {
        visited[r][c] = true;

        int same_component_neighbors = 0;
        for (int i = 0; i < 4; ++i) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (nr >= 0 && nr < R && nc >= 0 && nc < C) { // Check if neighbor is within grid bounds
                if (grid[nr][nc] == originalColor) { // Check if neighbor has the same original color
                    same_component_neighbors++;
                    if (!visited[nr][nc]) { // If neighbor is part of the component and not yet visited, recurse
                        dfs(nr, nc, grid);
                    }
                }
            }
        }

        // A cell (r, c) is a border cell if it has fewer than 4 neighbors
        // that are part of the same connected component (i.e., same original color and within bounds).
        // This condition covers cells on the grid boundary or adjacent to cells of a different color.
        if (same_component_neighbors < 4) {
            borderCells.push_back({r, c});
        }
    }

    std::vector<std::vector<int>> colorBorder(std::vector<std::vector<int>>& grid, int r0, int c0, int color) {
        R = grid.size();
        C = grid[0].size();
        originalColor = grid[r0][c0];
        visited.assign(R, std::vector<bool>(C, false)); // Initialize visited array

        dfs(r0, c0, grid); // Start DFS from (r0, c0)

        // Change the color of all identified border cells
        for (auto p : borderCells) {
            grid[p.first][p.second] = color;
        }

        return grid;
    }
};