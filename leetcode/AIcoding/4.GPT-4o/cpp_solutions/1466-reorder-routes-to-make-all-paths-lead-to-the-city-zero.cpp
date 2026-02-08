class Solution {
public:
    int minReorder(int n, vector<vector<int>>& connections) {
        vector<vector<int>> graph(n);
        vector<bool> visited(n, false);
        int reorderCount = 0;

        for (const auto& conn : connections) {
            graph[conn[0]].emplace_back(conn[1]);
            graph[conn[1]].emplace_back(-conn[0]); // negative to indicate direction
        }

        function<void(int)> dfs = [&](int city) {
            visited[city] = true;
            for (int next : graph[city]) {
                if (!visited[abs(next)]) {
                    if (next > 0) reorderCount++; // if it's a positive, we need to reorder
                    dfs(abs(next));
                }
            }
        };

        dfs(0);
        return reorderCount;
    }
};