class Solution {
public:
    double frogPosition(int n, vector<vector<int>>& edges, int t, int target) {
        vector<vector<int>> graph(n + 1);
        for (auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<bool> visited(n + 1, false);
        double result = dfs(1, target, t, graph, visited);
        return result;
    }

private:
    double dfs(int node, int target, int t, vector<vector<int>>& graph, vector<bool>& visited) {
        visited[node] = true;
        if (node == target) {
            if (t == 0) return 1.0;
            if (graph[node].size() == 1) return t == 0 ? 1.0 : 0.0;
        }
        int children = 0;
        for (int neighbor : graph[node]) {
            if (!visited[neighbor]) {
                children++;
            }
        }
        if (children == 0) return node == target ? 1.0 : 0.0;

        double probability = 0.0;
        for (int neighbor : graph[node]) {
            if (!visited[neighbor]) {
                probability += dfs(neighbor, target, t - 1, graph, visited) / children;
            }
        }
        return probability;
    }
};