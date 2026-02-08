class Solution {
public:
    vector<int> findRedundantDirectedConnection(vector<vector<int>>& edges) {
        int n = edges.size();
        vector<int> parent(n + 1, 0);
        vector<int> indegree(n + 1, 0);
        vector<int> candidate1, candidate2;

        for (auto& edge : edges) {
            int u = edge[0], v = edge[1];
            indegree[v]++;
            if (indegree[v] > 1) {
                candidate1 = {u, v};
                edge[1] = 0;
                break;
            }
        }

        for (auto& edge : edges) {
            int u = edge[0], v = edge[1];
            if (v == 0) continue;
            if (find(parent, u) == find(parent, v)) {
                candidate2 = {u, v};
            } else {
                unionSets(parent, u, v);
            }
        }

        return candidate1.empty() ? candidate2 : candidate1;
    }

private:
    int find(vector<int>& parent, int u) {
        if (parent[u] == 0) return u;
        return parent[u] = find(parent, parent[u]);
    }

    void unionSets(vector<int>& parent, int u, int v) {
        parent[find(parent, u)] = find(parent, v);
    }
};