class Solution {
public:
    vector<int> findRedundantDirectedConnection(vector<vector<int>>& edges) {
        int n = edges.size();
        vector<int> parent(n + 1);
        iota(parent.begin(), parent.end(), 0);
        vector<int> indegree(n + 1, 0);
        vector<int> edgeToRemove;

        for (auto& edge : edges) {
            indegree[edge[1]]++;
            if (indegree[edge[1]] > 1) {
                edgeToRemove = edge;
                edge[1] = 0;
            }
        }

        for (auto& edge : edges) {
            int u = edge[0], v = edge[1];
            if (v == 0) continue;
            if (find(u, parent) == find(v, parent)) {
                return edgeToRemove.empty() ? edge : edgeToRemove;
            }
            unionSets(u, v, parent);
        }
        return edgeToRemove.empty() ? edges.back() : edgeToRemove;
    }

private:
    int find(int u, vector<int>& parent) {
        if (parent[u] != u) {
            parent[u] = find(parent[u], parent);
        }
        return parent[u];
    }

    void unionSets(int u, int v, vector<int>& parent) {
        parent[find(u, parent)] = find(v, parent);
    }
};