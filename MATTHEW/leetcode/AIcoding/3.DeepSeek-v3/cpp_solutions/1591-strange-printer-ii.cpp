class Solution {
public:
    bool isPrintable(vector<vector<int>>& targetGrid) {
        int m = targetGrid.size();
        if (m == 0) return true;
        int n = targetGrid[0].size();

        unordered_map<int, vector<int>> colorBounds;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                int color = targetGrid[i][j];
                if (colorBounds.find(color) == colorBounds.end()) {
                    colorBounds[color] = {i, i, j, j};
                } else {
                    auto& bounds = colorBounds[color];
                    bounds[0] = min(bounds[0], i);
                    bounds[1] = max(bounds[1], i);
                    bounds[2] = min(bounds[2], j);
                    bounds[3] = max(bounds[3], j);
                }
            }
        }

        unordered_map<int, unordered_set<int>> graph;
        unordered_map<int, int> inDegree;

        for (auto& entry : colorBounds) {
            int color = entry.first;
            auto& bounds = entry.second;
            inDegree[color] = 0;
        }

        for (auto& entry : colorBounds) {
            int color = entry.first;
            auto& bounds = entry.second;
            for (int i = bounds[0]; i <= bounds[1]; ++i) {
                for (int j = bounds[2]; j <= bounds[3]; ++j) {
                    int c = targetGrid[i][j];
                    if (c != color) {
                        if (graph[c].count(color) == 0) {
                            graph[c].insert(color);
                            inDegree[color]++;
                        }
                    }
                }
            }
        }

        queue<int> q;
        for (auto& entry : inDegree) {
            if (entry.second == 0) {
                q.push(entry.first);
            }
        }

        int count = 0;
        while (!q.empty()) {
            int u = q.front();
            q.pop();
            count++;
            for (int v : graph[u]) {
                inDegree[v]--;
                if (inDegree[v] == 0) {
                    q.push(v);
                }
            }
        }

        return count == colorBounds.size();
    }
};