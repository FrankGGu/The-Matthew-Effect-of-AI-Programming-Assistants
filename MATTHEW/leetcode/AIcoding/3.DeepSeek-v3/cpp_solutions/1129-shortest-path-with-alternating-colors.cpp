class Solution {
public:
    vector<int> shortestAlternatingPaths(int n, vector<vector<int>>& redEdges, vector<vector<int>>& blueEdges) {
        vector<vector<pair<int, int>>> adj(n);
        for (auto& edge : redEdges) {
            adj[edge[0]].push_back({edge[1], 0});
        }
        for (auto& edge : blueEdges) {
            adj[edge[0]].push_back({edge[1], 1});
        }

        vector<vector<int>> dist(n, vector<int>(2, -1));
        queue<pair<int, int>> q;

        dist[0][0] = 0;
        dist[0][1] = 0;
        q.push({0, 0});
        q.push({0, 1});

        while (!q.empty()) {
            auto [node, color] = q.front();
            q.pop();

            for (auto& [neighbor, neighborColor] : adj[node]) {
                if (neighborColor != color && dist[neighbor][neighborColor] == -1) {
                    dist[neighbor][neighborColor] = dist[node][color] + 1;
                    q.push({neighbor, neighborColor});
                }
            }
        }

        vector<int> result(n);
        for (int i = 0; i < n; ++i) {
            if (dist[i][0] == -1 && dist[i][1] == -1) {
                result[i] = -1;
            } else if (dist[i][0] == -1) {
                result[i] = dist[i][1];
            } else if (dist[i][1] == -1) {
                result[i] = dist[i][0];
            } else {
                result[i] = min(dist[i][0], dist[i][1]);
            }
        }

        return result;
    }
};