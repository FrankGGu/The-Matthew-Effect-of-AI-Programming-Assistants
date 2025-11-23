class Solution {
public:
    int countCompleteComponents(int n, vector<vector<int>>& edges) {
        vector<vector<int>> graph(n);
        for (const auto& edge : edges) {
            graph[edge[0]].push_back(edge[1]);
            graph[edge[1]].push_back(edge[0]);
        }

        vector<bool> visited(n, false);
        int completeComponents = 0;

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                int size = 0, edgesCount = 0;
                dfs(i, graph, visited, size, edgesCount);
                if (edgesCount == size * (size - 1) / 2) {
                    completeComponents++;
                }
            }
        }
        return completeComponents;
    }

private:
    void dfs(int node, vector<vector<int>>& graph, vector<bool>& visited, int& size, int& edgesCount) {
        visited[node] = true;
        size++;
        edgesCount += graph[node].size();
        for (int neighbor : graph[node]) {
            if (!visited[neighbor]) {
                dfs(neighbor, graph, visited, size, edgesCount);
            }
        }
    }
};