#include <vector>
#include <queue>

class Solution {
public:
    int m, n;
    std::vector<std::vector<int>> heights_ref; // Renamed to avoid shadowing member 'heights'

    // Directions for moving to adjacent cells (up, down, left, right)
    int dr[4] = {-1, 1, 0, 0};
    int dc[4] = {0, 0, -1, 1};

    void dfs(int r, int c, std::vector<std::vector<bool>>& visited) {
        visited[r][c] = true;

        for (int i = 0; i < 4; ++i) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            // Check bounds, if not visited, and if water can flow from neighbor to current cell (uphill flow)
            if (nr >= 0 && nr < m && nc >= 0 && nc < n && !visited[nr][nc] && heights_ref[nr][nc] >= heights_ref[r][c]) {
                dfs(nr, nc, visited);
            }
        }
    }

    std::vector<std::vector<int>> pacificAtlantic(std::vector<std::vector<int>>& heights) {
        this->heights_ref = heights; // Store reference to heights matrix
        m = heights.size();
        if (m == 0) return {};
        n = heights[0].size();
        if (n == 0) return {};

        std::vector<std::vector<bool>> canReachPacific(m, std::vector<bool>(n, false));
        std::vector<std::vector<bool>> canReachAtlantic(m, std::vector<bool>(n, false));

        // Start DFS from all cells bordering the Pacific Ocean
        // Top row and left column
        for (int r = 0; r < m; ++r) {
            dfs(r, 0, canReachPacific); // Left column
        }
        for (int c = 0; c < n; ++c) {
            dfs(0, c, canReachPacific); // Top row
        }

        // Start DFS from all cells bordering the Atlantic Ocean
        // Bottom row and right column
        for (int r = 0; r < m; ++r) {
            dfs(r, n - 1, canReachAtlantic); // Right column
        }
        for (int c = 0; c < n; ++c) {
            dfs(m - 1, c, canReachAtlantic); // Bottom row
        }

        // Collect all cells that can reach both oceans
        std::vector<std::vector<int>> result;
        for (int r = 0; r < m; ++r) {
            for (int c = 0; c < n; ++c) {
                if (canReachPacific[r][c] && canReachAtlantic[r][c]) {
                    result.push_back({r, c});
                }
            }
        }

        return result;
    }
};