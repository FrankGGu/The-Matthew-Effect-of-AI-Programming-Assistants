#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int magnificentSets(int n, vector<vector<int>>& edges) {
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0] - 1].push_back(edge[1] - 1);
            adj[edge[1] - 1].push_back(edge[0] - 1);
        }

        vector<int> visited(n, 0);
        int max_total = 0;

        for (int i = 0; i < n; ++i) {
            if (visited[i] == 0) {
                vector<int> color(n, 0);
                queue<int> q;
                q.push(i);
                color[i] = 1;
                visited[i] = 1;
                bool is_bipartite = true;

                while (!q.empty()) {
                    int u = q.front();
                    q.pop();

                    for (int v : adj[u]) {
                        if (visited[v] == 0) {
                            visited[v] = 1;
                            color[v] = 1 - color[u];
                            q.push(v);
                        } else if (color[v] == color[u]) {
                            is_bipartite = false;
                            break;
                        }
                    }
                    if (!is_bipartite) break;
                }

                if (!is_bipartite) return -1;

                int max_dist_component = 0;
                vector<int> component_nodes;
                for (int j = 0; j < n; ++j) {
                    if (visited[j] == 1 && color[j] == 0 || visited[j] == 1 && color[j] == 1) {
                        component_nodes.push_back(j);
                    }
                }

                for (int start_node : component_nodes) {
                    vector<int> dist(n, -1);
                    queue<int> q2;
                    q2.push(start_node);
                    dist[start_node] = 1;

                    while (!q2.empty()) {
                        int u = q2.front();
                        q2.pop();

                        for (int v : adj[u]) {
                            if (dist[v] == -1) {
                                dist[v] = dist[u] + 1;
                                q2.push(v);
                            }
                        }
                    }
                    int max_dist = 0;
                    for(int node : component_nodes){
                        max_dist = max(max_dist, dist[node]);
                    }

                    max_dist_component = max(max_dist_component, max_dist);
                }

                for(int node : component_nodes){
                    visited[node] = 2;
                }
                max_total += max_dist_component;
            }
        }

        return max_total;
    }
};