#include <iostream>
#include <vector>
#include <queue>
#include <utility>
#include <algorithm>

using namespace std;

class Solution {
public:
    int cutOffTree(vector<vector<int>>& forest) {
        int m = forest.size();
        int n = forest[0].size();
        vector<pair<int, int>> trees;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (forest[i][j] > 1) {
                    trees.push_back({i, j});
                }
            }
        }
        sort(trees.begin(), trees.end(), [&](const pair<int, int>& a, const pair<int, int>& b) {
            return forest[a.first][a.second] < forest[b.first][b.second];
        });
        int result = 0;
        int x = 0, y = 0;
        for (auto& tree : trees) {
            int steps = bfs(forest, x, y, tree.first, tree.second, m, n);
            if (steps == -1) return -1;
            result += steps;
            x = tree.first;
            y = tree.second;
        }
        return result;
    }

private:
    int bfs(vector<vector<int>>& forest, int start_x, int start_y, int end_x, int end_y, int m, int n) {
        vector<vector<bool>> visited(m, vector<bool>(n, false));
        queue<pair<int, int>> q;
        q.push({start_x, start_y});
        visited[start_x][start_y] = true;
        int steps = 0;
        int dx[] = {-1, 1, 0, 0};
        int dy[] = {0, 0, -1, 1};
        while (!q.empty()) {
            int size = q.size();
            for (int i = 0; i < size; ++i) {
                auto [x, y] = q.front();
                q.pop();
                if (x == end_x && y == end_y) {
                    return steps;
                }
                for (int k = 0; k < 4; ++k) {
                    int nx = x + dx[k];
                    int ny = y + dy[k];
                    if (nx >= 0 && nx < m && ny >= 0 && ny < n && !visited[nx][ny] && forest[nx][ny] > 0) {
                        visited[nx][ny] = true;
                        q.push({nx, ny});
                    }
                }
            }
            ++steps;
        }
        return -1;
    }
};