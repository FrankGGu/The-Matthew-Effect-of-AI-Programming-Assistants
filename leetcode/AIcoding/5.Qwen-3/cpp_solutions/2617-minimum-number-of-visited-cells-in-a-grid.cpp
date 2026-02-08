#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int countVisitedCells(int m, int n, int k) {
        vector<vector<int>> grid(m, vector<int>(n, 0));
        queue<pair<int, int>> q;
        q.push({0, 0});
        grid[0][0] = 1;
        int steps = 0;

        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                auto [x, y] = q.front();
                q.pop();
                if (steps == k) return grid[x][y];
                for (int dx = -1; dx <= 1; ++dx) {
                    for (int dy = -1; dy <= 1; ++dy) {
                        if (abs(dx) + abs(dy) != 1) continue;
                        int nx = x + dx;
                        int ny = y + dy;
                        if (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] == 0) {
                            grid[nx][ny] = grid[x][y] + 1;
                            q.push({nx, ny});
                        }
                    }
                }
            }
            ++steps;
        }
        return grid[m-1][n-1];
    }
};