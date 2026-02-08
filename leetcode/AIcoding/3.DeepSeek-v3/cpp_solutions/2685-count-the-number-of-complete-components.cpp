class Solution {
public:
    int countCompleteComponents(int n, vector<vector<int>>& edges) {
        vector<vector<int>> adj(n);
        for (auto& e : edges) {
            adj[e[0]].push_back(e[1]);
            adj[e[1]].push_back(e[0]);
        }

        vector<bool> visited(n, false);
        int res = 0;

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                vector<int> component;
                dfs(i, adj, visited, component);
                bool isComplete = true;
                int m = component.size();
                for (int u : component) {
                    if (adj[u].size() != m - 1) {
                        isComplete = false;
                        break;
                    }
                }
                if (isComplete) {
                    res++;
                }
            }
        }

        return res;
    }

private:
    void dfs(int u, vector<vector<int>>& adj, vector<bool>& visited, vector<int>& component) {
        visited[u] = true;
        component.push_back(u);
        for (int v : adj[u]) {
            if (!visited[v]) {
                dfs(v, adj, visited, component);
            }
        }
    }
};