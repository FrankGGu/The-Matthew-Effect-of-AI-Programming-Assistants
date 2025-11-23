class Solution {
public:
    int countComponents(int n, vector<vector<int>>& edges) {
        vector<int> parent(n);
        for (int i = 0; i < n; ++i) {
            parent[i] = i;
        }

        function<int(int)> find = [&](int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        };

        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int rootU = find(u);
            int rootV = find(v);
            if (rootU != rootV) {
                parent[rootV] = rootU;
            }
        }

        unordered_set<int> roots;
        for (int i = 0; i < n; ++i) {
            roots.insert(find(i));
        }

        return roots.size();
    }
};