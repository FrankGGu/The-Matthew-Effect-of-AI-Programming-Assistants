#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int minReorder(int n, vector<vector<int>>& connections) {
        vector<vector<pair<int, int>>> adj(n);
        for (auto& connection : connections) {
            adj[connection[0]].push_back({connection[1], 1});
            adj[connection[1]].push_back({connection[0], 0});
        }

        int reorders = 0;
        vector<bool> visited(n, false);
        queue<int> q;
        q.push(0);
        visited[0] = true;

        while (!q.empty()) {
            int u = q.front();
            q.pop();

            for (auto& neighbor : adj[u]) {
                int v = neighbor.first;
                int cost = neighbor.second;
                if (!visited[v]) {
                    reorders += cost;
                    visited[v] = true;
                    q.push(v);
                }
            }
        }

        return reorders;
    }
};