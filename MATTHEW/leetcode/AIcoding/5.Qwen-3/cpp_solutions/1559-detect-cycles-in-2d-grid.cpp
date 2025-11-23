#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>
#include <utility>

using namespace std;

class Solution {
public:
    bool containsCycle(vector<vector<char>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();
        vector<vector<bool>> visited(rows, vector<bool>(cols, false));

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (!visited[i][j]) {
                    queue<pair<int, int>> q;
                    q.push({i, j});
                    visited[i][j] = true;
                    unordered_map<char, pair<int, int>> parent;
                    parent[grid[i][j]] = {-1, -1};

                    while (!q.empty()) {
                        auto [x, y] = q.front();
                        q.pop();

                        for (auto [dx, dy] : vector<pair<int, int>>{{-1, 0}, {1, 0}, {0, -1}, {0, 1}}) {
                            int nx = x + dx;
                            int ny = y + dy;

                            if (nx >= 0 && ny >= 0 && nx < rows && ny < cols && grid[nx][ny] == grid[x][y]) {
                                if (visited[nx][ny]) {
                                    if (parent[grid[x][y]] != make_pair(nx, ny)) {
                                        return true;
                                    }
                                } else {
                                    visited[nx][ny] = true;
                                    parent[grid[nx][ny]] = {x, y};
                                    q.push({nx, ny});
                                }
                            }
                        }
                    }
                }
            }
        }

        return false;
    }
};