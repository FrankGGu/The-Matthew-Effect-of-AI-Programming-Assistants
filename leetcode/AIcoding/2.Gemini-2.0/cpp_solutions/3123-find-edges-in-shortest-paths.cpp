#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<vector<int>> findTheEdges(int n, vector<vector<int>>& edges, int source, int destination) {
        vector<vector<pair<int, int>>> adj(n);
        for (int i = 0; i < edges.size(); ++i) {
            adj[edges[i][0]].push_back({edges[i][1], i});
            adj[edges[i][1]].push_back({edges[i][0], i});
        }

        vector<int> dist(n, -1);
        vector<vector<int>> paths(n);
        queue<int> q;

        dist[source] = 0;
        q.push(source);

        while (!q.empty()) {
            int u = q.front();
            q.pop();

            for (auto& neighbor : adj[u]) {
                int v = neighbor.first;
                int edge_index = neighbor.second;

                if (dist[v] == -1) {
                    dist[v] = dist[u] + 1;
                    paths[v].push_back(u);
                    q.push(v);
                } else if (dist[v] == dist[u] + 1) {
                    paths[v].push_back(u);
                }
            }
        }

        vector<bool> used(edges.size(), false);
        queue<int> path_q;
        path_q.push(destination);

        while (!path_q.empty()) {
            int u = path_q.front();
            path_q.pop();

            for (int v : paths[u]) {
                for (int i = 0; i < edges.size(); ++i) {
                    if ((edges[i][0] == u && edges[i][1] == v) || (edges[i][0] == v && edges[i][1] == u)) {
                        used[i] = true;
                        break;
                    }
                }
                if (v != source) {
                    path_q.push(v);
                }
            }
        }

        vector<vector<int>> result;
        for (int i = 0; i < edges.size(); ++i) {
            if (used[i]) {
                result.push_back(edges[i]);
            }
        }

        return result;
    }
};