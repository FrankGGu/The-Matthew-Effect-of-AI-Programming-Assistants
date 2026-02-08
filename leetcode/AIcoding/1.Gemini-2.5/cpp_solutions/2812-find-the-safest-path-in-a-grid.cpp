#include <vector>
#include <queue>
#include <algorithm>

class Solution {
public:
    int maximumSafenessFactor(std::vector<std::vector<int>>& grid) {
        int n = grid.size();
        std::vector<std::vector<int>> dist(n, std::vector<int>(n, -1));
        std::queue<std::pair<int, int>> q;

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == 1) {
                    q.push({i, j});
                    dist[i][j] = 0;
                }
            }
        }

        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        while (!q.empty()) {
            auto [r, c] = q.front();
            q.pop();

            for (int i = 0; i < 4; ++i) {
                int nr = r + dr[i];
                int nc = c + dc[i];
                if (nr >= 0 && nr < n && nc >= 0 && nc < n && dist[nr][nc] == -1) {
                    dist[nr][nc] = dist[r][c] + 1;
                    q.push({nr, nc});
                }
            }
        }

        int low = 0, high = 0;
        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                high = std::max(high, dist[i][j]);
            }
        }

        int ans = 0;
        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (canReach(mid, dist, n)) {
                ans = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        return ans;
    }

private:
    bool canReach(int min_safeness, const std::vector<std::vector<int>>& dist, int n) {
        if (dist[0][0] < min_safeness || dist[n - 1][n - 1] < min_safeness) {
            return false;
        }

        std::queue<std::pair<int, int>> q;
        std::vector<std::vector<bool>> visited(n, std::vector<bool>(n, false));

        q.push({0, 0});
        visited[0][0] = true;

        int dr[] = {-1, 1, 0, 0};
        int dc[] = {0, 0, -1, 1};

        while (!q.empty()) {
            auto [r, c] = q.front();
            q.pop();

            if (r == n - 1 && c == n - 1) {
                return true;
            }

            for (int i = 0; i < 4; ++i) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                if (nr >= 0 && nr < n && nc >= 0 && nc < n && !visited[nr][nc] && dist[nr][nc] >= min_safeness) {
                    visited[nr][nc] = true;
                    q.push({nr, nc});
                }
            }
        }

        return false;
    }
};