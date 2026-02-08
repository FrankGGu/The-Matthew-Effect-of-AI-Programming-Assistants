class Solution {
public:
    int maxEnjoyment(int n, vector<vector<int>>& edges, vector<int>& enjoyment) {
        vector<vector<int>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        int maxEnjoy = 0;

        function<void(int, int, int)> dfs = [&](int node, int parent, int currentEnjoy) {
            currentEnjoy += enjoyment[node];
            maxEnjoy = max(maxEnjoy, currentEnjoy);
            for (int neighbor : graph[node]) {
                if (neighbor != parent) {
                    dfs(neighbor, node, currentEnjoy);
                }
            }
        };

        dfs(0, -1, 0);
        return maxEnjoy;
    }
};