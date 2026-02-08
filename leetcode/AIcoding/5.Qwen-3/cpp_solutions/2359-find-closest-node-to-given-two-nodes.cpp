#include <iostream>
#include <vector>
#include <unordered_map>
#include <queue>

using namespace std;

class Solution {
public:
    int closestNode(int n, vector<vector<int>>& edges, int node1, int node2) {
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        auto bfs = [&](int start) -> vector<int> {
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
                    }
                }
            }
            return dist;
        };

        vector<int> d1 = bfs(node1);
        vector<int> d2 = bfs(node2);

        int minDist = INT_MAX;
        int result = 0;
        for (int i = 0; i < n; ++i) {
            if (d1[i] != -1 && d2[i] != -1) {
                int currentDist = max(d1[i], d2[i]);
                if (currentDist < minDist) {
                    minDist = currentDist;
                    result = i;
                }
            }
        }

        return result;
    }
};