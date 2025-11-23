class Solution {
public:
    int networkBecomesIdle(vector<vector<int>>& edges, vector<int>& patience) {
        int n = patience.size();
        vector<vector<int>> graph(n);
        for (auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<int> dist(n, -1);
        queue<int> q;
        q.push(0);
        dist[0] = 0;

        while (!q.empty()) {
            int u = q.front();
            q.pop();
            for (int v : graph[u]) {
                if (dist[v] == -1) {
                    dist[v] = dist[u] + 1;
                    q.push(v);
                }
            }
        }

        int res = 0;
        for (int i = 1; i < n; ++i) {
            int d = dist[i] * 2;
            int p = patience[i];
            int lastSent = (d - 1) / p * p;
            int finishTime = lastSent + d;
            res = max(res, finishTime);
        }

        return res + 1;
    }
};