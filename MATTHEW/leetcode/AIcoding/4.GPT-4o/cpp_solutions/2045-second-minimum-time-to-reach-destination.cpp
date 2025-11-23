class Solution {
public:
    int secondMinimum(int n, vector<vector<int>>& edges, int time, int change) {
        vector<vector<int>> graph(n + 1);
        for (auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<vector<long long>> dist(n + 1, vector<long long>(2, LLONG_MAX));
        dist[1][0] = 0;

        priority_queue<tuple<long long, int, int>, vector<tuple<long long, int, int>>, greater<tuple<long long, int, int>>> pq;
        pq.push({0, 1, 0});

        while (!pq.empty()) {
            auto [d, node, t] = pq.top();
            pq.pop();
            if (node == n && t == 1) return d;

            for (int nei : graph[node]) {
                long long wait = (d / change) % 2 == 0 ? 0 : change - (d % change);
                long long next_time = d + wait + time;

                if (next_time < dist[nei][0]) {
                    dist[nei][1] = dist[nei][0];
                    dist[nei][0] = next_time;
                    pq.push({next_time, nei, 0});
                } else if (next_time < dist[nei][1] && next_time != dist[nei][0]) {
                    dist[nei][1] = next_time;
                    pq.push({next_time, nei, 1});
                }
            }
        }
        return -1;
    }
};