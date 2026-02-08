#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int minimalSteps(vector<string>& maze) {
        int rows = maze.size();
        int cols = maze[0].size();
        vector<vector<int>> dist(rows, vector<int>(cols, -1));
        queue<pair<int, int>> q;
        vector<vector<int>> dirs{{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (maze[i][j] == 'S') {
                    q.push({i, j});
                    dist[i][j] = 0;
                }
            }
        }

        while (!q.empty()) {
            auto [x, y] = q.front();
            q.pop();

            for (auto& dir : dirs) {
                int nx = x + dir[0];
                int ny = y + dir[1];

                if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && maze[nx][ny] != 'X' && dist[nx][ny] == -1) {
                    dist[nx][ny] = dist[x][y] + 1;
                    q.push({nx, ny});
                }
            }
        }

        int result = -1;
        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (maze[i][j] == 'T') {
                    result = dist[i][j];
                }
            }
        }

        return result;
    }
};