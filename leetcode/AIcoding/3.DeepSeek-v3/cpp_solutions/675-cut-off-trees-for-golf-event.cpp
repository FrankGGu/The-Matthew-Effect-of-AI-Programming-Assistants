#include <vector>
#include <queue>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int cutOffTree(vector<vector<int>>& forest) {
        if (forest.empty() || forest[0].empty()) return -1;
        int m = forest.size(), n = forest[0].size();
        vector<vector<int>> trees;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (forest[i][j] > 1) {
                    trees.push_back({forest[i][j], i, j});
                }
            }
        }
        sort(trees.begin(), trees.end());
        int res = 0;
        int x = 0, y = 0;
        for (auto& tree : trees) {
            int tx = tree[1], ty = tree[2];
            int dist = bfs(forest, x, y, tx, ty);
            if (dist == -1) return -1;
            res += dist;
            x = tx;
            y = ty;
            forest[x][y] = 1;
        }
        return res;
    }

private:
    int bfs(vector<vector<int>>& forest, int sx, int sy, int tx, int ty) {
        if (sx == tx && sy == ty) return 0;
        int m = forest.size(), n = forest[0].size();
        queue<pair<int, int>> q;
        q.push({sx, sy});
        vector<vector<int>> visited(m, vector<int>(n, 0));
        visited[sx][sy] = 1;
        int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        int steps = 0;
        while (!q.empty()) {
            int size = q.size();
            steps++;
            for (int i = 0; i < size; ++i) {
                auto p = q.front(); q.pop();
                int x = p.first, y = p.second;
                for (auto& dir : dirs) {
                    int nx = x + dir[0], ny = y + dir[1];
                    if (nx < 0 || nx >= m || ny < 0 || ny >= n || forest[nx][ny] == 0 || visited[nx][ny]) continue;
                    if (nx == tx && ny == ty) return steps;
                    visited[nx][ny] = 1;
                    q.push({nx, ny});
                }
            }
        }
        return -1;
    }
};