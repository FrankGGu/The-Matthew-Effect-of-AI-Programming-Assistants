#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int networkBecomesIdle(vector<vector<int>>& edges, vector<int>& patience) {
        int n = patience.size();
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<int> dist(n, -1);
        queue<int> q;
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

        int max_time = 0;
        for (int i = 1; i < n; ++i) {
            int travel_time = 2 * dist[i];
            int last_send_time = (travel_time / patience[i]) * patience[i];
            if (last_send_time == travel_time) {
                last_send_time -= patience[i];
            }

            int idle_time = last_send_time + travel_time + 1;
            max_time = max(max_time, idle_time);
        }

        return max_time;
    }
};