class Solution {
public:
    int minReorder(int n, vector<vector<int>>& connections) {
        vector<vector<int>> graph(n);
        for (auto& conn : connections) {
            graph[conn[0]].push_back(conn[1]);
            graph[conn[1]].push_back(-conn[0]);
        }

        vector<bool> visited(n, false);
        return dfs(0, graph, visited);
    }

private:
    int dfs(int node, vector<vector<int>>& graph, vector<bool>& visited) {
        visited[node] = true;
        int changes = 0;
        for (int neighbor : graph[node]) {
            if (!visited[abs(neighbor)]) {
                changes += neighbor >= 0 ? 1 : 0;
                changes += dfs(abs(neighbor), graph, visited);
            }
        }
        return changes;
    }
};