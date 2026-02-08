class Solution {
public:
    vector<int> findRedundantEdge(vector<vector<int>>& edges) {
        int n = edges.size();
        vector<int> parent(n + 1);
        iota(parent.begin(), parent.end(), 0);

        function<int(int)> find = [&](int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        };

        for (const auto& edge : edges) {
            int u = edge[0], v = edge[1];
            int pu = find(u), pv = find(v);
            if (pu == pv) {
                return edge;
            }
            parent[pu] = pv;
        }
        return {};
    }
};