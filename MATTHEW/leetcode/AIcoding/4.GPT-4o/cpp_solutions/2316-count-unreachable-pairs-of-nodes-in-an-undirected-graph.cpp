class Solution {
public:
    long long countPairs(int n, vector<vector<int>>& edges) {
        vector<vector<int>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<bool> visited(n, false);
        vector<long long> componentSizes;

        function<void(int)> dfs = [&](int node) {
            visited[node] = true;
            componentSizes.back()++;
            for (int neighbor : graph[node]) {
                if (!visited[neighbor]) {
                    dfs(neighbor);
                }
            }
        };

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                componentSizes.push_back(0);
                dfs(i);
            }
        }

        long long totalPairs = 0;
        long long sum = 0;
        for (long long size : componentSizes) {
            totalPairs += size * sum;
            sum += size;
        }

        return totalPairs;
    }
};