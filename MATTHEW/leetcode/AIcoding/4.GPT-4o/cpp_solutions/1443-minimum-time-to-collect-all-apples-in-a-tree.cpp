class Solution {
public:
    int minTime(int n, vector<vector<int>>& edges, vector<bool>& hasApple) {
        vector<vector<int>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }
        return dfs(0, -1, graph, hasApple);
    }

    int dfs(int node, int parent, const vector<vector<int>>& graph, const vector<bool>& hasApple) {
        int totalTime = 0;
        for (int neighbor : graph[node]) {
            if (neighbor != parent) {
                int time = dfs(neighbor, node, graph, hasApple);
                if (time > 0 || hasApple[neighbor]) {
                    totalTime += time + 2;
                }
            }
        }
        return totalTime;
    }
};