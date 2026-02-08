class Solution {
public:
    int networkBecomesIdle(vector<vector<int>>& edges, vector<int>& patience) {
        int n = patience.size();
        vector<vector<int>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<int> dist(n, INT_MAX);
        dist[0] = 0;
        queue<int> q;
        q.push(0);

        while (!q.empty()) {
            int node = q.front();
            q.pop();
            for (int neighbor : graph[node]) {
                if (dist[neighbor] == INT_MAX) {
                    dist[neighbor] = dist[node] + 1;
                    q.push(neighbor);
                }
            }
        }

        int maxTime = 0;
        for (int i = 1; i < n; ++i) {
            int roundTripTime = dist[i] * 2;
            int waitTime = (roundTripTime - 1) / patience[i] * patience[i];
            maxTime = max(maxTime, roundTripTime + waitTime);
        }

        return maxTime + 1;
    }
};