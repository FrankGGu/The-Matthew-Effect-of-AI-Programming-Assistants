class Solution {
public:
    vector<int> findRedundantDirectedConnection(vector<vector<int>>& edges) {
        int n = edges.size();
        vector<int> parent(n + 1, 0);
        vector<int> candidate1, candidate2;

        for (auto &edge : edges) {
            int u = edge[0], v = edge[1];
            if (parent[v] != 0) {
                candidate1 = {parent[v], v};
                candidate2 = edge;
                edge[1] = 0;
                break;
            }
            parent[v] = u;
        }

        for (int i = 1; i <= n; ++i) parent[i] = i;

        for (auto &edge : edges) {
            int u = edge[0], v = edge[1];
            if (v == 0) continue;
            int rootU = find(parent, u);
            if (rootU == v) {
                if (candidate1.empty()) return edge;
                else return candidate1;
            }
            parent[v] = rootU;
        }

        return candidate2;
    }

private:
    int find(vector<int>& parent, int x) {
        if (parent[x] != x) {
            parent[x] = find(parent, parent[x]);
        }
        return parent[x];
    }
};