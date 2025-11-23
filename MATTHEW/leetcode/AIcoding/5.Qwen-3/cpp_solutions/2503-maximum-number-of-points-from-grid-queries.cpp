#include <iostream>
#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    vector<int> maxPoints(vector<vector<int>>& grid, vector<int>& queries) {
        int m = grid.size();
        int n = grid[0].size();
        vector<vector<int>> sortedGrid(m * n);
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                sortedGrid[i * n + j] = grid[i][j];
            }
        }
        sort(sortedGrid.begin(), sortedGrid.end());

        vector<int> result(queries.size());
        vector<int> sortedQueries(queries);
        sort(sortedQueries.begin(), sortedQueries.end());

        vector<int> indexMap(queries.size());
        for (int i = 0; i < queries.size(); ++i) {
            indexMap[i] = i;
        }
        sort(indexMap.begin(), indexMap.end(), [&](int a, int b) {
            return queries[a] < queries[b];
        });

        int ptr = 0;
        vector<vector<bool>> visited(m, vector<bool>(n, false));
        priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<>> pq;

        for (int i = 0; i < queries.size(); ++i) {
            int q = queries[indexMap[i]];
            while (ptr < m * n && sortedGrid[ptr] < q) {
                int x = ptr / n;
                int y = ptr % n;
                if (!visited[x][y]) {
                    visited[x][y] = true;
                    pq.push({grid[x][y], {x, y}});
                }
                ++ptr;
            }

            int total = 0;
            vector<vector<bool>> used(m, vector<bool>(n, false));
            priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<>> tempPq;
            while (!pq.empty()) {
                auto [val, pos] = pq.top();
                pq.pop();
                if (used[pos.first][pos.second]) continue;
                used[pos.first][pos.second] = true;
                total += val;
                for (int dx = -1; dx <= 1; ++dx) {
                    for (int dy = -1; dy <= 1; ++dy) {
                        if (abs(dx) + abs(dy) == 1) {
                            int nx = pos.first + dx;
                            int ny = pos.second + dy;
                            if (nx >= 0 && nx < m && ny >= 0 && ny < n && !used[nx][ny]) {
                                tempPq.push({grid[nx][ny], {nx, ny}});
                            }
                        }
                    }
                }
            }
            pq = tempPq;
            result[indexMap[i]] = total;
        }

        return result;
    }
};