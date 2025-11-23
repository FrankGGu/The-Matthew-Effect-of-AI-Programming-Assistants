#include <iostream>
#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int shortestCycle(int n, vector<vector<int>>& edges) {
        vector<vector<int>> adj(n);
        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        int min_cycle = INT_MAX;

        for (int start = 0; start < n; ++start) {
            vector<int> dist(n, -1);
            queue<int> q;
            q.push(start);
            dist[start] = 0;

            while (!q.empty()) {
                int u = q.front();
                q.pop();

                for (int v : adj[u]) {
                    if (dist[v] == -1) {
                        dist[v] = dist[u] + 1;
                        q.push(v);
                    } else if (dist[v] >= dist[u]) {
                        min_cycle = min(min_cycle, dist[u] + dist[v] + 1);
                    }
                }
            }
        }

        return min_cycle == INT_MAX ? -1 : min_cycle;
    }
};