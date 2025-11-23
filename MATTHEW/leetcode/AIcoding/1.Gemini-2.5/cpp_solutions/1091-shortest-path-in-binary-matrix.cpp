#include <vector>
#include <queue>
#include <utility> // For std::pair

class Solution {
public:
    int shortestPathBinaryMatrix(std::vector<std::vector<int>>& grid) {
        int n = grid.size();

        if (grid[0][0] == 1 || grid[n - 1][n - 1] == 1) {
            return -1;
        }

        if (n == 1) {
            return 1;
        }

        std::queue<std::pair<int, int>> q;

        q.push({0, 0});
        grid[0][0] = 1; 

        int dr[] = {-1, -1, -1, 0, 0, 1, 1, 1};
        int dc[] = {-1, 0, 1, -1, 1, -1, 0, 1};

        while (!q.empty()) {
            std::pair<int, int> curr = q.front();
            q.pop();

            int r = curr.first;
            int c = curr.second;
            int dist = grid[r][c]; 

            if (r == n - 1 && c == n - 1) {
                return dist;
            }

            for (int i = 0; i < 8; ++i) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                if (nr >= 0 && nr < n && nc >= 0 && nc < n) {
                    if (grid[nr][nc] == 0) {
                        grid[nr][nc] = dist + 1; 
                        q.push({nr, nc});
                    }
                }
            }
        }

        return -1;
    }
};