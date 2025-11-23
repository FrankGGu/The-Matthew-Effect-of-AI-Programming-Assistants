class Solution {
public:
    int timeToMarkNodes(vector<vector<int>>& edges, int time) {
        int n = edges.size() + 1;
        vector<vector<int>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<bool> visited(n, false);
        int maxTime = 0;

        function<int(int)> dfs = [&](int node) {
            visited[node] = true;
            int maxChildTime = 0;
            for (int neighbor : graph[node]) {
                if (!visited[neighbor]) {
                    maxChildTime = max(maxChildTime, dfs(neighbor));
                }
            }
            return maxChildTime + time;
        };

        dfs(0);
        return maxTime;
    }
};