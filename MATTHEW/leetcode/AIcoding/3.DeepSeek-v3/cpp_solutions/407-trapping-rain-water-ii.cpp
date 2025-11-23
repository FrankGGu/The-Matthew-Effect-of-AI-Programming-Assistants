class Solution {
public:
    int trapRainWater(vector<vector<int>>& heightMap) {
        if (heightMap.empty() || heightMap[0].empty()) return 0;
        int m = heightMap.size(), n = heightMap[0].size();
        priority_queue<pair<int, pair<int, int>>, vector<pair<int, pair<int, int>>>, greater<pair<int, pair<int, int>>>> pq;
        vector<vector<bool>> visited(m, vector<bool>(n, false));

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (i == 0 || i == m - 1 || j == 0 || j == n - 1) {
                    pq.push({heightMap[i][j], {i, j}});
                    visited[i][j] = true;
                }
            }
        }

        int res = 0;
        int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        int maxHeight = 0;

        while (!pq.empty()) {
            auto curr = pq.top();
            pq.pop();
            int h = curr.first;
            int i = curr.second.first;
            int j = curr.second.second;
            maxHeight = max(maxHeight, h);

            for (auto dir : dirs) {
                int ni = i + dir[0];
                int nj = j + dir[1];
                if (ni >= 0 && ni < m && nj >= 0 && nj < n && !visited[ni][nj]) {
                    if (heightMap[ni][nj] < maxHeight) {
                        res += maxHeight - heightMap[ni][nj];
                    }
                    visited[ni][nj] = true;
                    pq.push({heightMap[ni][nj], {ni, nj}});
                }
            }
        }

        return res;
    }
};