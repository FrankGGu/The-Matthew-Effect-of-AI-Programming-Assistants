class Solution {
public:
    vector<int> modifyGraphEdges(int n, vector<vector<int>>& edges) {
        vector<int> result(edges.size());
        vector<bool> seen(n + 1, false);
        for (const auto& edge : edges) {
            seen[edge[0]] = true;
            seen[edge[1]] = true;
        }

        int count = 1;
        for (int i = 1; i <= n; ++i) {
            if (!seen[i]) {
                count++;
            }
        }

        for (int i = 0; i < edges.size(); ++i) {
            int u = edges[i][0];
            int v = edges[i][1];
            result[i] = edges[i][2] == 1 ? count : edges[i][2];
        }

        return result;
    }
};