#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int amountOfTime(int n, vector<vector<int>>& edges, int startNode) {
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        int max_time = 0;
        vector<int> dist(n, -1);
        queue<int> q;

        dist[startNode] = 0;
        q.push(startNode);

        while (!q.empty()) {
            int u = q.front();
            q.pop();

            for (int v : adj[u]) {
                if (dist[v] == -1) {
                    dist[v] = dist[u] + 1;
                    max_time = max(max_time, dist[v]);
                    q.push(v);
                }
            }
        }

        return max_time;
    }
};