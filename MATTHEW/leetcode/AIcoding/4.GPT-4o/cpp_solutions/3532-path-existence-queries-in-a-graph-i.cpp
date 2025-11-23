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
            result.push_back(dfs(graph, query[0], query[1], visited));
        }
        return result;
    }

private:
    bool dfs(const vector<vector<int>>& graph, int start, int end, vector<bool>& visited) {
        if (start == end) return true;
        visited[start] = true;
        for (int neighbor : graph[start]) {
            if (!visited[neighbor] && dfs(graph, neighbor, end, visited)) {
                return true;
            }
        }
        return false;
    }
};