using namespace std;

class Graph {
private:
    vector<vector<pair<int, int>>> adj;
    int n;

public:
    Graph(int n, vector<vector<int>>& edges) {
        this->n = n;
        adj.resize(n);
        for (auto& e : edges) {
            adj[e[0]].push_back({e[1], e[2]});
        }
    }

    void addEdge(vector<int> edge) {
        adj[edge[0]].push_back({edge[1], edge[2]});
    }

    int shortestPath(int node1, int node2) {
        vector<int> dist(n, INT_MAX);
        dist[node1] = 0;
        priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
        pq.push({0, node1});

        while (!pq.empty()) {
            int d = pq.top().first;
            int u = pq.top().second;
            pq.pop();

            if (u == node2) return d;
            if (d > dist[u]) continue;

            for (auto& edge : adj[u]) {
                int v = edge.first;
                int w = edge.second;
                if (dist[v] > d + w) {
                    dist[v] = d + w;
                    pq.push({dist[v], v});
                }
            }
        }
        return -1;
    }
};