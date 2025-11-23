#include <vector>
#include <queue>
#include <limits>

using namespace std;

class Graph {
public:
    int n;
    vector<vector<pair<int, int>>> adj;

    Graph(int n, vector<vector<int>>& edges) : n(n) {
        adj.resize(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back({edge[1], edge[2]});
        }
    }

    void addEdge(vector<int> edge) {
        adj[edge[0]].push_back({edge[1], edge[2]});
    }

    int shortestPath(int node1, int node2) {
        vector<int> dist(n, numeric_limits<int>::max());
        dist[node1] = 0;
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
        pq.push({0, node1});

        while (!pq.empty()) {
            int d = pq.top().first;
            int u = pq.top().second;
            pq.pop();

            if (d > dist[u]) continue;

            for (auto& neighbor : adj[u]) {
                int v = neighbor.first;
                int weight = neighbor.second;
                if (dist[v] > dist[u] + weight) {
                    dist[v] = dist[u] + weight;
                    pq.push({dist[v], v});
                }
            }
        }

        return (dist[node2] == numeric_limits<int>::max()) ? -1 : dist[node2];
    }
};