#include <vector>
#include <queue>
#include <algorithm>

class Solution {
public:
    int networkBecomesIdle(std::vector<std::vector<int>>& edges, std::vector<int>& patience) {
        int n = patience.size();
        std::vector<std::vector<int>> adj(n);
        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        std::vector<int> dist(n, -1);
        std::queue<int> q;

        q.push(0);
        dist[0] = 0;

        while (!q.empty()) {
            int u = q.front();
            q.pop();

            for (int v : adj[u]) {
                if (dist[v] == -1) {
                    dist[v] = dist[u] + 1;
                    q.push(v);
                }
            }
        }

        int max_idle_time = 0;

        for (int i = 1; i < n; ++i) {
            int d_i = dist[i];
            int p_i = patience[i];

            int time_for_initial_reply = 2 * d_i;

            int current_server_idle_time;

            int k_max = (time_for_initial_reply - 1) / p_i;

            int last_sent_time = k_max * p_i;

            current_server_idle_time = last_sent_time + time_for_initial_reply;

            max_idle_time = std::max(max_idle_time, current_server_idle_time);
        }

        return max_idle_time;
    }
};