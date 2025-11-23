class Solution {
public:
    vector<vector<int>> getAncestors(int n, vector<vector<int>>& edges) {
        vector<vector<int>> graph(n);
        vector<vector<int>> ancestors(n);
        for (const auto& edge : edges) {
            graph[edge[1]].push_back(edge[0]);
        }

        for (int i = 0; i < n; ++i) {
            vector<bool> visited(n, false);
            dfs(i, graph, visited, ancestors[i]);
        }

        for (auto& anc : ancestors) {
            sort(anc.begin(), anc.end());
        }

        return ancestors;
    }

private:
    void dfs(int node, const vector<vector<int>>& graph, vector<bool>& visited, vector<int>& anc) {
        for (int neighbor : graph[node]) {
            if (!visited[neighbor]) {
                visited[neighbor] = true;
                anc.push_back(neighbor);
                dfs(neighbor, graph, visited, anc);
            }
        }
    }
};