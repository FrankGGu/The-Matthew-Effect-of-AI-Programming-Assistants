#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<vector<int>> pacificAtlantic(vector<vector<int>>& heights) {
        if (heights.empty() || heights[0].empty()) return {};

        int m = heights.size(), n = heights[0].size();
        vector<vector<bool>> pacific(m, vector<bool>(n, false));
        vector<vector<bool>> atlantic(m, vector<bool>(n, false));

        queue<pair<int, int>> pQueue, aQueue;

        for (int i = 0; i < m; ++i) {
            pacific[i][0] = true;
            pQueue.push({i, 0});
            atlantic[i][n - 1] = true;
            aQueue.push({i, n - 1});
        }

        for (int j = 0; j < n; ++j) {
            pacific[0][j] = true;
            pQueue.push({0, j});
            atlantic[m - 1][j] = true;
            aQueue.push({m - 1, j});
        }

        int dx[] = {0, 0, 1, -1};
        int dy[] = {1, -1, 0, 0};

        auto bfs = [&](vector<vector<bool>>& ocean, queue<pair<int, int>>& q) {
            while (!q.empty()) {
                int x = q.front().first, y = q.front().second;
                q.pop();

                for (int i = 0; i < 4; ++i) {
                    int nx = x + dx[i], ny = y + dy[i];
                    if (nx >= 0 && nx < m && ny >= 0 && ny < n && !ocean[nx][ny] && heights[nx][ny] >= heights[x][y]) {
                        ocean[nx][ny] = true;
                        q.push({nx, ny});
                    }
                }
            }
        };

        bfs(pacific, pQueue);
        bfs(atlantic, aQueue);

        vector<vector<int>> result;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (pacific[i][j] && atlantic[i][j]) {
                    result.push_back({i, j});
                }
            }
        }

        return result;
    }
};