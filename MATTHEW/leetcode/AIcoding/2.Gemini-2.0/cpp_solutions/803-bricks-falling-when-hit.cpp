#include <vector>

using namespace std;

class Solution {
public:
    vector<int> hitBricks(vector<vector<int>>& grid, vector<vector<int>>& hits) {
        int h = grid.size(), w = grid[0].size(), l = hits.size();
        vector<int> ans(l, 0);

        vector<vector<int>> initial_grid = grid;

        for (auto& hit : hits) {
            grid[hit[0]][hit[1]] = 0;
        }

        vector<int> parent(h * w, 0);
        vector<int> size(h * w, 1);
        for (int i = 0; i < h * w; ++i) {
            parent[i] = i;
        }

        function<int(int)> find = [&](int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        };

        auto unite = [&](int x, int y) {
            x = find(x);
            y = find(y);
            if (x != y) {
                parent[x] = y;
                size[y] += size[x];
            }
        };

        for (int i = 0; i < h; ++i) {
            for (int j = 0; j < w; ++j) {
                if (grid[i][j] == 1) {
                    int index = i * w + j;
                    if (i == 0) {
                        unite(index, h * w);
                    }
                    if (i > 0 && grid[i - 1][j] == 1) {
                        unite(index, (i - 1) * w + j);
                    }
                    if (j > 0 && grid[i][j - 1] == 1) {
                        unite(index, i * w + j - 1);
                    }
                }
            }
        }

        for (int i = l - 1; i >= 0; --i) {
            int row = hits[i][0], col = hits[i][1];
            if (initial_grid[row][col] == 0) continue;

            int before = size[find(h * w)];
            grid[row][col] = 1;
            int index = row * w + col;
            if (row == 0) {
                unite(index, h * w);
            }
            if (row > 0 && grid[row - 1][col] == 1) {
                unite(index, (row - 1) * w + col);
            }
            if (row < h - 1 && grid[row + 1][col] == 1) {
                unite(index, (row + 1) * w + col);
            }
            if (col > 0 && grid[row][col - 1] == 1) {
                unite(index, row * w + col - 1);
            }
            if (col < w - 1 && grid[row][col + 1] == 1) {
                unite(index, row * w + col + 1);
            }

            int after = size[find(h * w)];
            ans[i] = max(0, after - before - 1);
        }

        return ans;
    }
};