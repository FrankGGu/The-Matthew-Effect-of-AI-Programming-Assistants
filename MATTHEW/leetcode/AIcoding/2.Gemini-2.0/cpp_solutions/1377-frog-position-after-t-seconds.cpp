#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    double frogPosition(int n, vector<vector<int>>& edges, int t, int target) {
        vector<vector<int>> adj(n + 1);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<bool> visited(n + 1, false);
        queue<pair<int, double>> q;
        q.push({1, 1.0});
        visited[1] = true;

        for (int i = 0; i < t; ++i) {
            int sz = q.size();
            for (int j = 0; j < sz; ++j) {
                int u = q.front().first;
                double prob = q.front().second;
                q.pop();

                int unvisited_neighbors = 0;
                for (int v : adj[u]) {
                    if (!visited[v]) {
                        unvisited_neighbors++;
                    }
                }

                if (unvisited_neighbors == 0) {
                    q.push({u, prob});
                    continue;
                }

                for (int v : adj[u]) {
                    if (!visited[v]) {
                        visited[v] = true;
                        q.push({v, prob / unvisited_neighbors});
                    }
                }
            }
        }

        while (!q.empty()) {
            int u = q.front().first;
            double prob = q.front().second;
            q.pop();

            if (u == target) {
                return prob;
            }
        }

        return 0.0;
    }
};