#include <iostream>
#include <vector>
#include <queue>
#include <unordered_map>
#include <utility>

using namespace std;

class Solution {
public:
    int minMovesToBoxToTarget(vector<vector<char>>& grid) {
        int rows = grid.size();
        int cols = grid[0].size();
        pair<int, int> player;
        pair<int, int> box;
        vector<pair<int, int>> targets;

        for (int i = 0; i < rows; ++i) {
            for (int j = 0; j < cols; ++j) {
                if (grid[i][j] == 'S') {
                    player = {i, j};
                } else if (grid[i][j] == 'B') {
                    box = {i, j};
                } else if (grid[i][j] == 'T') {
                    targets.push_back({i, j});
                }
            }
        }

        vector<vector<int>> visited(rows * cols, vector<int>(rows * cols, -1));
        queue<tuple<int, int, int, int>> q;
        q.push({player.first, player.second, box.first, box.second});
        visited[player.first * cols + player.second][box.first * cols + box.second] = 0;

        vector<vector<int>> directions = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

        while (!q.empty()) {
            auto [px, py, bx, by] = q.front();
            q.pop();

            for (auto& dir : directions) {
                int npx = px + dir[0];
                int npy = py + dir[1];

                if (npx >= 0 && npy >= 0 && npx < rows && npy < cols && grid[npx][npy] != '#') {
                    if (npx == bx && npy == by) {
                        int nbx = bx + dir[0];
                        int nby = by + dir[1];
                        if (nbx >= 0 && nby >= 0 && nbx < rows && nby < cols && grid[nbx][nby] != '#') {
                            int key = npx * cols + npy;
                            int boxKey = nbx * cols + nby;
                            if (visited[key][boxKey] == -1) {
                                visited[key][boxKey] = visited[px * cols + py][bx * cols + by] + 1;
                                q.push({npx, npy, nbx, nby});
                            }
                        }
                    } else {
                        int key = npx * cols + npy;
                        int boxKey = bx * cols + by;
                        if (visited[key][boxKey] == -1) {
                            visited[key][boxKey] = visited[px * cols + py][bx * cols + by] + 1;
                            q.push({npx, npy, bx, by});
                        }
                    }
                }
            }
        }

        int result = -1;
        for (auto& target : targets) {
            int key = player.first * cols + player.second;
            int boxKey = target.first * cols + target.second;
            if (visited[key][boxKey] != -1) {
                if (result == -1 || visited[key][boxKey] < result) {
                    result = visited[key][boxKey];
                }
            }
        }

        return result;
    }
};