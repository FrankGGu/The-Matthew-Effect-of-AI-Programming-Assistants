class Solution {
public:
    int minimumScore(int root, vector<vector<int>>& edges) {
        int n = edges.size() + 1;
        vector<vector<int>> graph(n);
        for (auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<int> minScore(n, INT_MAX);
        vector<bool> visited(n, false);

        function<void(int, int)> dfs = [&](int node, int score) {
            visited[node] = true;
            minScore[node] = min(minScore[node], score);
            for (int neighbor : graph[node]) {
                if (!visited[neighbor]) {
                    dfs(neighbor, score);
                }
            }
        };

        for (auto& edge : edges) {
            dfs(edge[0], edge[2]);
            dfs(edge[1], edge[2]);
        }

        int result = INT_MAX;
        for (int i = 0; i < n; ++i) {
            if (minScore[i] != INT_MAX) {
                result = min(result, minScore[i]);
            }
        }

        return result;
    }
};