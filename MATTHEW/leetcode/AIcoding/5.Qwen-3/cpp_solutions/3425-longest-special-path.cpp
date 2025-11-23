#include <iostream>
#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int longestPath(int n, vector<vector<int>>& edges, int k) {
        vector<vector<int>> adj(n);
        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<int> dist(n, 0);
        queue<int> q;
        vector<bool> visited(n, false);

        for (int i = 0; i < n; ++i) {
            if (adj[i].size() == 1) {
                q.push(i);
                visited[i] = true;
            }
        }

        while (!q.empty()) {
            int node = q.front();
            q.pop();

            for (int neighbor : adj[node]) {
                if (!visited[neighbor]) {
                    dist[neighbor] = max(dist[neighbor], dist[node] + 1);
                    visited[neighbor] = true;
                    q.push(neighbor);
                }
            }
        }

        int maxDist = 0;
        for (int i = 0; i < n; ++i) {
            if (dist[i] > maxDist) {
                maxDist = dist[i];
            }
        }

        return maxDist;
    }
};