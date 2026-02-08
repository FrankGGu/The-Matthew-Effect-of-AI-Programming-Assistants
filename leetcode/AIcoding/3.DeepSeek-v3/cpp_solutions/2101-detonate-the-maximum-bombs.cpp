class Solution {
public:
    int maximumDetonation(vector<vector<int>>& bombs) {
        int n = bombs.size();
        vector<vector<int>> graph(n);

        for (int i = 0; i < n; ++i) {
            long long x1 = bombs[i][0], y1 = bombs[i][1], r1 = bombs[i][2];
            for (int j = 0; j < n; ++j) {
                if (i == j) continue;
                long long x2 = bombs[j][0], y2 = bombs[j][1];
                long long dx = x1 - x2, dy = y1 - y2;
                if (dx * dx + dy * dy <= r1 * r1) {
                    graph[i].push_back(j);
                }
            }
        }

        int maxBombs = 0;
        for (int i = 0; i < n; ++i) {
            vector<bool> visited(n, false);
            queue<int> q;
            q.push(i);
            visited[i] = true;
            int count = 1;

            while (!q.empty()) {
                int u = q.front();
                q.pop();
                for (int v : graph[u]) {
                    if (!visited[v]) {
                        visited[v] = true;
                        q.push(v);
                        ++count;
                    }
                }
            }
            maxBombs = max(maxBombs, count);
        }

        return maxBombs;
    }
};