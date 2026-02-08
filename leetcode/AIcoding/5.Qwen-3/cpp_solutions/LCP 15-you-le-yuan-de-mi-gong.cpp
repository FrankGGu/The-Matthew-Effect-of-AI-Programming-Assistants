#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int escapeMaze(vector<vector<int>>& maze, int k) {
        int rows = maze.size();
        int cols = maze[0].size();
        vector<vector<int>> visited(rows, vector<int>(cols, -1));
        queue<pair<int, int>> q;
        q.push({0, 0});
        visited[0][0] = 0;

        int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        while (!q.empty()) {
            auto [x, y] = q.front();
            q.pop();

            if (x == rows - 1 && y == cols - 1) {
                return visited[x][y];
            }

            for (auto& dir : directions) {
                int nx = x + dir[0];
                int ny = y + dir[1];

                if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && visited[nx][ny] == -1) {
                    if (maze[nx][ny] == 0) {
                        visited[nx][ny] = visited[x][y] + 1;
                        q.push({nx, ny});
                    } else if (maze[nx][ny] == 1 && visited[x][y] < k) {
                        visited[nx][ny] = visited[x][y] + 1;
                        q.push({nx, ny});
                    }
                }
            }
        }

        return -1;
    }
};