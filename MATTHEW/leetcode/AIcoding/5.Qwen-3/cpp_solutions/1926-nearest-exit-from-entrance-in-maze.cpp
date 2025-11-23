#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int nearestExit(vector<vector<char>>& maze, vector<int>& entrance) {
        int rows = maze.size();
        int cols = maze[0].size();

        queue<pair<int, int>> q;
        q.push({entrance[0], entrance[1]});
        vector<vector<bool>> visited(rows, vector<bool>(cols, false));
        visited[entrance[0]][entrance[1]] = true;

        int steps = 0;
        int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                auto [r, c] = q.front();
                q.pop();

                for (auto& dir : directions) {
                    int nr = r + dir[0];
                    int nc = c + dir[1];

                    if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && !visited[nr][nc]) {
                        if (nr == 0 || nr == rows - 1 || nc == 0 || nc == cols - 1) {
                            return steps + 1;
                        }
                        visited[nr][nc] = true;
                        q.push({nr, nc});
                    }
                }
            }
            ++steps;
        }

        return -1;
    }
};