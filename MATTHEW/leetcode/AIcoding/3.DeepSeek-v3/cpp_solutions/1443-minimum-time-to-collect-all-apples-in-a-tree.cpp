class Solution {
public:
    int minTime(int n, vector<vector<int>>& edges, vector<bool>& hasApple) {
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }
        vector<bool> visited(n, false);
        return dfs(0, adj, hasApple, visited);
    }

    int dfs(int node, vector<vector<int>>& adj, vector<bool>& hasApple, vector<bool>& visited) {
        visited[node] = true;
        int totalTime = 0;
        for (int neighbor : adj[node]) {
            if (!visited[neighbor]) {
                int childTime = dfs(neighbor, adj, hasApple, visited);
                if (childTime > 0 || hasApple[neighbor]) {
                    totalTime += childTime + 2;
                }
            }
        }
        return totalTime;
    }
};