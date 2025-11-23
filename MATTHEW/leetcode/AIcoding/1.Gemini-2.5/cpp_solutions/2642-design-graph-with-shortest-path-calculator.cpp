#include <vector>
#include <queue>
#include <limits>

class Graph {
private:
    int n_nodes;
    std::vector<std::vector<std::pair<int, int>>> adj;

public:
    Graph(int n, std::vector<std::vector<int>>& edges) {
        n_nodes = n;
        adj.resize(n);
        for (const auto& edge : edges) {
            adj[edge[0]].push_back({edge[1], edge[2]});
        }
    }

    void addEdge(std::vector<int> edge) {
        adj[edge[0]].push_back({edge[1], edge[2]});
    }

    int shortestPath(int node1, int node2) {
        std::vector<long long> dist(n_nodes, std::numeric_limits<long long>::max());
        std::priority_queue<std::pair<long long, int>, 
                            std::vector<std::pair<long long, int>>, 
                            std::greater<std::pair<long long, int>>> pq;

        dist[node1] = 0;
        pq.push({0, node1});

        while (!pq.empty()) {
            long long d = pq.top().first;
            int u = pq.top().second;
            pq.pop();

            if (d > dist[u]) {
                continue;
            }
            if (u == node2) {
                return static_cast<int>(d);
            }

            for (auto& edge : adj[u]) {
                int v = edge.first;
                int weight = edge.second;

                if (dist[u] + weight < dist[v]) {
                    dist[v] = dist[u] + weight;
                    pq.push({dist[v], v});
                }
            }
        }

        return -1;
    }
};