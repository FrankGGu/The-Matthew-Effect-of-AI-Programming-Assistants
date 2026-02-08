#include <vector>
#include <queue>
#include <climits>

using namespace std;

class Solution {
public:
    vector<vector<int>> modifiedGraphEdges(int n, vector<vector<int>>& edges, int source, int destination, int target) {
        vector<vector<pair<int, int>>> adj(n);
        vector<vector<int>> modified_edges = edges;

        for (int i = 0; i < edges.size(); ++i) {
            adj[edges[i][0]].push_back({edges[i][1], edges[i][2]});
            adj[edges[i][1]].push_back({edges[i][0], edges[i][2]});
        }

        for (int i = 0; i < edges.size(); ++i) {
            if (edges[i][2] == -1) {
                modified_edges[i][2] = 1;
                adj[edges[i][0]].erase(remove_if(adj[edges[i][0]].begin(), adj[edges[i][0]].end(),
                                                 [&](const pair<int, int>& p) { return p.first == edges[i][1]; }), adj[edges[i][0]].end());
                adj[edges[i][1]].erase(remove_if(adj[edges[i][1]].begin(), adj[edges[i][1]].end(),
                                                 [&](const pair<int, int>& p) { return p.first == edges[i][0]; }), adj[edges[i][1]].end());

                adj[edges[i][0]].push_back({edges[i][1], 1});
                adj[edges[i][1]].push_back({edges[i][0], 1});

                modified_edges[i][2] = 1;
            }
        }

        long long dist = dijkstra(n, adj, source, destination);

        if (dist > target) {
            return {};
        }

        for (int i = 0; i < edges.size(); ++i) {
            if (edges[i][2] == -1) {
                adj[edges[i][0]].erase(remove_if(adj[edges[i][0]].begin(), adj[edges[i][0]].end(),
                                                 [&](const pair<int, int>& p) { return p.first == edges[i][1]; }), adj[edges[i][0]].end());
                adj[edges[i][1]].erase(remove_if(adj[edges[i][1]].begin(), adj[edges[i][1]].end(),
                                                 [&](const pair<int, int>& p) { return p.first == edges[i][0]; }), adj[edges[i][1]].end());
                int diff = target - dist;
                int new_weight = modified_edges[i][2] + diff;
                modified_edges[i][2] = new_weight;
                if(new_weight < 1){
                    modified_edges[i][2] = 2000000000;
                }

                adj[edges[i][0]].push_back({edges[i][1], modified_edges[i][2]});
                adj[edges[i][1]].push_back({edges[i][0], modified_edges[i][2]});

                dist = dijkstra(n, adj, source, destination);
                if (dist > target) {
                    modified_edges[i][2] = 2000000000;
                    adj[edges[i][0]].erase(remove_if(adj[edges[i][0]].begin(), adj[edges[i][0]].end(),
                                                 [&](const pair<int, int>& p) { return p.first == edges[i][1]; }), adj[edges[i][0]].end());
                    adj[edges[i][1]].erase(remove_if(adj[edges[i][1]].begin(), adj[edges[i][1]].end(),
                                                 [&](const pair<int, int>& p) { return p.first == edges[i][0]; }), adj[edges[i][1]].end());
                    adj[edges[i][0]].push_back({edges[i][1], 2000000000});
                    adj[edges[i][1]].push_back({edges[i][0], 2000000000});
                }
            }
        }

        dist = dijkstra(n, adj, source, destination);
        if(dist != target){
            return {};
        }

        for (auto& edge : modified_edges) {
            if (edge[2] > 100000) {
                edge[2] = -1;
            }
        }

        return modified_edges;
    }

private:
    long long dijkstra(int n, vector<vector<pair<int, int>>>& adj, int source, int destination) {
        vector<long long> dist(n, LLONG_MAX);
        dist[source] = 0;
        priority_queue<pair<long long, int>, vector<pair<long long, int>>, greater<pair<long long, int>>> pq;
        pq.push({0, source});

        while (!pq.empty()) {
            long long d = pq.top().first;
            int u = pq.top().second;
            pq.pop();

            if (d > dist[u]) continue;

            for (auto& edge : adj[u]) {
                int v = edge.first;
                int weight = edge.second;

                if (dist[v] > dist[u] + weight) {
                    dist[v] = dist[u] + weight;
                    pq.push({dist[v], v});
                }
            }
        }

        return (dist[destination] == LLONG_MAX) ? LLONG_MAX : dist[destination];
    }
};