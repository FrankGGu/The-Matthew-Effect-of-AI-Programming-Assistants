class Solution {
public:
    vector<bool> checkPaths(int n, vector<vector<int>>& edges, vector<vector<int>>& queries) {
        vector<vector<int>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<bool> result;
        for (const auto& query : queries) {
            vector<bool> visited(n, false);
            result.push_back(dfs(graph, visited, query[0], query[1]));
        }
        return result;
    }

private:
    bool dfs(const vector<vector<int>>& graph, vector<bool>& visited, int current, int target) {
        if (current == target) return true;
        visited[current] = true;
        for (int neighbor : graph[current]) {
            if (!visited[neighbor] && dfs(graph, visited, neighbor, target)) {
                return true;
            }
        }
        return false;
    }
};