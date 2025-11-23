class Solution {
public:
    int electricCarPlan(vector<vector<int>>& paths, int cnt, int start, int end, vector<int>& charge) {
        int n = charge.size();
        vector<vector<pair<int, int>>> adj(n);
        for (auto& path : paths) {
            int u = path[0], v = path[1], w = path[2];
            adj[u].emplace_back(v, w);
            adj[v].emplace_back(u, w);
        }

        priority_queue<tuple<int, int, int>, vector<tuple<int, int, int>>, greater<>> pq;
        vector<vector<int>> dist(n, vector<int>(cnt + 1, INT_MAX));
        dist[start][0] = 0;
        pq.emplace(0, start, 0);

        while (!pq.empty()) {
            auto [time, u, c] = pq.top();
            pq.pop();
            if (u == end) return time;
            if (time > dist[u][c]) continue;

            if (c < cnt) {
                int newTime = time + charge[u];
                if (newTime < dist[u][c + 1]) {
                    dist[u][c + 1] = newTime;
                    pq.emplace(newTime, u, c + 1);
                }
            }

            for (auto [v, w] : adj[u]) {
                if (c >= w) {
                    int newC = c - w;
                    if (time + w < dist[v][newC]) {
                        dist[v][newC] = time + w;
                        pq.emplace(time + w, v, newC);
                    }
                }
            }
        }
        return -1;
    }
};