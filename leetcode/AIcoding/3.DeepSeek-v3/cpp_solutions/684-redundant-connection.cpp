class Solution {
public:
    vector<int> findRedundantConnection(vector<vector<int>>& edges) {
        int n = edges.size();
        vector<int> parent(n + 1);
        for (int i = 1; i <= n; ++i) {
            parent[i] = i;
        }

        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int rootU = find(parent, u);
            int rootV = find(parent, v);
            if (rootU == rootV) {
                return edge;
            } else {
                parent[rootV] = rootU;
            }
        }
        return {};
    }

private:
    int find(vector<int>& parent, int x) {
        if (parent[x] != x) {
            parent[x] = find(parent, parent[x]);
        }
        return parent[x];
    }
};