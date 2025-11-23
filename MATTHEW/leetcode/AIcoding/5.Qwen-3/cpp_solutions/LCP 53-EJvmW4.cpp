#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int minDays(vector<int>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();

        vector<vector<int>> visited(rows, vector<int>(cols, 0));
        int count = 0;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (grid[i][j] == 1 && visited[i][j] == 0) {
                    ++count;
                    bfs(grid, visited, i, j);
                }
            }
        }

        if (count != 1) return 0;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (grid[i][j] == 1) {
                    grid[i][j] = 0;
                    vector<vector<int>> new_visited(rows, vector<int>(cols, 0));
                    int new_count = 0;

                    for (int x = 0; x < rows; ++x) {
                        for (int y = 0; y < cols; ++y) {
                            if (grid[x][y] == 1 && new_visited[x][y] == 0) {
                                ++new_count;
                                bfs(grid, new_visited, x, y);
                            }
                        }
                    }

                    if (new_count != 1) return 1;
                    grid[i][j] = 1;
                }
            }
        }

        return 2;
    }

private:
    void bfs(vector<int>& grid, vector<vector<int>>& visited, int i, int j) {
        queue<pair<int, int>> q;
        q.push({i, j});
        visited[i][j] = 1;

        int rows = grid.size();
        int cols = grid[0].size();

        int dir[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        while (!q.empty()) {
            auto [x, y] = q.front();
            q.pop();

            for (int k = 0; k < 4; ++k) {
                int nx = x + dir[k][0];
                int ny = y + dir[k][1];

                if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && grid[nx] != 0 && visited[nx][ny] == 0) {
                    visited[nx][ny] = 1;
                    q.push({nx, ny});
                }
            }
        }
    }
};