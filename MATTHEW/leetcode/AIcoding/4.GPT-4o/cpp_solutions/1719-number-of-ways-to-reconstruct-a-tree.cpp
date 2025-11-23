class Solution {
public:
    int reconstruct(int n, vector<vector<int>>& edges) {
        if (edges.size() != n - 1) return 0;

        vector<int> degree(n + 1, 0);
        for (const auto& edge : edges) {
            degree[edge[0]]++;
            degree[edge[1]]++;
        }

        int root = 0;
        for (int i = 1; i <= n; ++i) {
            if (degree[i] == 1) {
                root++;
            }
        }

        return root == 1 ? 1 : 0;
    }
};