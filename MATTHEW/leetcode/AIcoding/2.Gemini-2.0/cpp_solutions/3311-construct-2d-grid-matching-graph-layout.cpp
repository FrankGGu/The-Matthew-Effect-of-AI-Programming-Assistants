#include <vector>

using namespace std;

class Solution {
public:
    vector<vector<int>> construct2DArray(int m, int n) {
        vector<vector<int>> grid(m, vector<int>(n));
        vector<vector<int>> adj(m * n);

        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                int u = i * n + j;
                if (i > 0) {
                    int v = (i - 1) * n + j;
                    adj[u].push_back(v);
                }
                if (i < m - 1) {
                    int v = (i + 1) * n + j;
                    adj[u].push_back(v);
                }
                if (j > 0) {
                    int v = i * n + (j - 1);
                    adj[u].push_back(v);
                }
                if (j < n - 1) {
                    int v = i * n + (j + 1);
                    adj[u].push_back(v);
                }
            }
        }

        vector<bool> visited(m * n, false);
        vector<int> order;
        function<void(int)> dfs1 = [&](int u) {
            visited[u] = true;
            for (int v : adj[u]) {
                if (!visited[v]) {
                    dfs1(v);
                }
            }
            order.push_back(u);
        };

        for (int i = 0; i < m * n; ++i) {
            if (!visited[i]) {
                dfs1(i);
            }
        }

        reverse(order.begin(), order.end());

        vector<int> assignment(m * n, -1);
        int component = 0;
        function<void(int)> dfs2 = [&](int u) {
            assignment[u] = component;
            for (int v : adj[u]) {
                if (assignment[v] == -1) {
                    dfs2(v);
                }
            }
        };

        for (int u : order) {
            if (assignment[u] == -1) {
                dfs2(u);
                component++;
            }
        }

        for(int i = 0; i < m; ++i){
            for(int j = 0; j < n; ++j){
                grid[i][j] = assignment[i * n + j];
            }
        }

        return grid;
    }
};