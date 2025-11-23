class Solution {
public:
    int maximumPathQuality(vector<int>& values, vector<vector<int>>& edges, int maxTime) {
        int n = values.size();
        vector<vector<pair<int, int>>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].emplace_back(edge[1], edge[2]);
            graph[edge[1]].emplace_back(edge[0], edge[2]);
        }

        int maxQuality = 0;
        vector<bool> visited(n, false);
        visited[0] = true;

        function<void(int, int, int)> dfs = [&](int node, int timeSpent, int quality) {
            if (node == n - 1) {
                maxQuality = max(maxQuality, quality);
            }

            for (const auto& neighbor : graph[node]) {
                int nextNode = neighbor.first;
                int travelTime = neighbor.second;

                if (timeSpent + travelTime <= maxTime) {
                    int newQuality = quality + (visited[nextNode] ? 0 : values[nextNode]);
                    visited[nextNode] = true;
                    dfs(nextNode, timeSpent + travelTime, newQuality);
                    visited[nextNode] = false;
                }
            }
        };

        dfs(0, 0, values[0]);
        return maxQuality;
    }
};