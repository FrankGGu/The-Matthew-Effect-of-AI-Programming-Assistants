class Solution {
public:
    vector<int> parent;
    vector<int> rank;

    int find(int u) {
        if (parent[u] != u) {
            parent[u] = find(parent[u]);
        }
        return parent[u];
    }

    void unionSet(int u, int v, int weight) {
        int rootU = find(u);
        int rootV = find(v);
        if (rootU != rootV) {
            if (rank[rootU] > rank[rootV]) {
                parent[rootV] = rootU;
            } else if (rank[rootU] < rank[rootV]) {
                parent[rootU] = rootV;
            } else {
                parent[rootV] = rootU;
                rank[rootU]++;
            }
        }
    }

    vector<int> minimumCost(int n, vector<vector<int>>& edges, vector<vector<int>>& query) {
        parent.resize(n);
        rank.resize(n, 0);
        for (int i = 0; i < n; ++i) {
            parent[i] = i;
        }

        for (auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];
            unionSet(u, v, w);
        }

        vector<int> minCost(n, INT_MAX);
        for (auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];
            int root = find(u);
            minCost[root] &= w;
        }

        vector<int> result;
        for (auto& q : query) {
            int s = q[0];
            int t = q[1];
            if (s == t) {
                result.push_back(0);
                continue;
            }
            if (find(s) != find(t)) {
                result.push_back(-1);
            } else {
                result.push_back(minCost[find(s)]);
            }
        }
        return result;
    }
};