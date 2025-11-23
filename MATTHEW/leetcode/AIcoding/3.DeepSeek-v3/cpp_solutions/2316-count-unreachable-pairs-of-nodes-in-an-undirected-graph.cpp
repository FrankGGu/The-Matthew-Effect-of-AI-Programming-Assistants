class Solution {
public:
    void dfs(int node, vector<vector<int>>& adj, vector<bool>& visited, long long& count) {
        visited[node] = true;
        count++;
        for (int neighbor : adj[node]) {
            if (!visited[neighbor]) {
                dfs(neighbor, adj, visited, count);
            }
        }
    }

    long long countPairs(int n, vector<vector<int>>& edges) {
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<bool> visited(n, false);
        long long totalPairs = (long long)n * (n - 1) / 2;
        long long connectedPairs = 0;

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                long long count = 0;
                dfs(i, adj, visited, count);
                connectedPairs += count * (count - 1) / 2;
            }
        }

        return totalPairs - connectedPairs;
    }
};