class Solution {
public:
    int makeConnected(int n, vector<vector<int>>& connections) {
        if (connections.size() < n - 1) return -1;

        vector<int> parent(n);
        for (int i = 0; i < n; i++) parent[i] = i;

        function<int(int)> find = [&](int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        };

        int components = n;
        for (const auto& conn : connections) {
            int root1 = find(conn[0]);
            int root2 = find(conn[1]);
            if (root1 != root2) {
                parent[root1] = root2;
                components--;
            }
        }
        return components - 1;
    }
};