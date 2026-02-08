#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>
#include <utility>

using namespace std;

class Solution {
public:
    int shortestPathAllKeys(vector<string>& grid) {
        int m = grid.size();
        int n = grid[0].size();
        int startRow = -1, startCol = -1;
        int keyCount = 0;

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == '@') {
                    startRow = i;
                    startCol = j;
                } else if (islower(grid[i][j])) {
                    keyCount++;
                }
            }
        }

        int targetState = (1 << keyCount) - 1;

        vector<vector<vector<int>>> visited(m, vector<vector<int>>(n, vector<int>(1 << keyCount, 0)));
        queue<pair<int, int>> q;
        q.push({startRow, startCol});
        visited[startRow][startCol][0] = 1;

        int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        int steps = 0;

        while (!q.empty()) {
            int size = q.size();
            for (int k = 0; k < size; ++k) {
                auto [r, c] = q.front();
                q.pop();

                if (visited[r][c][targetState]) {
                    return steps;
                }

                for (auto& dir : dirs) {
                    int nr = r + dir[0];
                    int nc = c + dir[1];

                    if (nr >= 0 && nr < m && nc >= 0 && nc < n && grid[nr][nc] != '#') {
                        char cell = grid[nr][nc];
                        if (isupper(cell)) {
                            int keyBit = cell - 'A';
                            if ((visited[r][c][0] & (1 << keyBit)) == 0) {
                                continue;
                            }
                        }

                        int newState = visited[r][c][0];
                        if (islower(cell)) {
                            int keyBit = cell - 'a';
                            newState |= (1 << keyBit);
                        }

                        if (!visited[nr][nc][newState]) {
                            visited[nr][nc][newState] = 1;
                            q.push({nr, nc});
                        }
                    }
                }
            }
            steps++;
        }

        return -1;
    }
};