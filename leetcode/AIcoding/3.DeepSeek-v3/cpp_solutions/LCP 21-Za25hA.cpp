#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    int chaseGame(vector<vector<int>>& edges, int startA, int startB) {
        int n = edges.size();
        vector<vector<int>> adj(n + 1);
        for (auto& e : edges) {
            adj[e[0]].push_back(e[1]);
            adj[e[1]].push_back(e[0]);
        }

        vector<int> distA(n + 1, INT_MAX);
        vector<int> distB(n + 1, INT_MAX);
        bfs(startA, adj, distA);
        bfs(startB, adj, distB);

        int maxDist = 0;
        for (int i = 1; i <= n; ++i) {
            if (distA[i] > distB[i] + 1) {
                maxDist = max(maxDist, distA[i]);
            }
        }

        if (maxDist == 0) {
            return 1;
        }

        vector<int> parent(n + 1, -1);
        vector<int> depth(n + 1, 0);
        vector<bool> visited(n + 1, false);
        queue<int> q;
        q.push(1);
        visited[1] = true;
        int cycleLen = -1;

        while (!q.empty()) {
            int u = q.front();
            q.pop();
            for (int v : adj[u]) {
                if (!visited[v]) {
                    visited[v] = true;
                    parent[v] = u;
                    depth[v] = depth[u] + 1;
                    q.push(v);
                } else if (v != parent[u]) {
                    cycleLen = depth[u] + depth[v] + 1;
                }
            }
            if (cycleLen != -1) break;
        }

        if (cycleLen >= 4 && maxDist > cycleLen - 1) {
            return -1;
        } else {
            return maxDist;
        }
    }

private:
    void bfs(int start, vector<vector<int>>& adj, vector<int>& dist) {
        queue<int> q;
        q.push(start);
        dist[start] = 0;
        while (!q.empty()) {
            int u = q.front();
            q.pop();
            for (int v : adj[u]) {
                if (dist[v] == INT_MAX) {
                    dist[v] = dist[u] + 1;
                    q.push(v);
                }
            }
        }
    }
};