class UnionFind {
public:
    vector<int> parent, rank;

    UnionFind(int n) {
        parent.resize(n);
        rank.resize(n, 1);
        for (int i = 0; i < n; ++i) parent[i] = i;
    }

    int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    void unionSet(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) {
            if (rank[rootX] > rank[rootY]) {
                parent[rootY] = rootX;
            } else if (rank[rootX] < rank[rootY]) {
                parent[rootX] = rootY;
            } else {
                parent[rootY] = rootX;
                rank[rootX]++;
            }
        }
    }
};

class Solution {
public:
    vector<int> shortestDistance(int n, vector<vector<int>>& roads, vector<vector<int>>& queries) {
        UnionFind uf(n);
        vector<int> dist(n, INT_MAX);
        vector<vector<pair<int, int>>> graph(n);

        for (auto& road : roads) {
            int u = road[0], v = road[1], w = road[2];
            graph[u].emplace_back(v, w);
            graph[v].emplace_back(u, w);
            uf.unionSet(u, v);
        }

        vector<int> result;

        for (auto& query : queries) {
            int u = query[0], v = query[1];
            if (uf.find(u) != uf.find(v)) {
                result.push_back(-1);
                continue;
            }

            priority_queue<pair<int, int>, vector<pair<int, int>>, greater<pair<int, int>>> pq;
            pq.push({0, u});
            dist[u] = 0;

            while (!pq.empty()) {
                auto [d, node] = pq.top();
                pq.pop();

                if (node == v) {
                    result.push_back(d);
                    break;
                }

                for (auto& [neighbor, weight] : graph[node]) {
                    if (d + weight < dist[neighbor]) {
                        dist[neighbor] = d + weight;
                        pq.push({dist[neighbor], neighbor});
                    }
                }
            }
            if (dist[v] == INT_MAX) result.push_back(-1);
            fill(dist.begin(), dist.end(), INT_MAX);
        }

        return result;
    }
};