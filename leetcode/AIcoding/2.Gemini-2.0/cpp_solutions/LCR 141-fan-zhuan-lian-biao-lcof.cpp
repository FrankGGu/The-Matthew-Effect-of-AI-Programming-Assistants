#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    int trainingPlan(int n, vector<vector<int>>& records) {
        vector<int> indegree(n + 1, 0);
        vector<int> outdegree(n + 1, 0);
        vector<vector<int>> adj(n + 1);

        for (auto& record : records) {
            int u = record[0];
            int v = record[1];
            adj[u].push_back(v);
            indegree[v]++;
            outdegree[u]++;
        }

        int start_node = -1;
        for (int i = 1; i <= n; ++i) {
            if (indegree[i] == 0) {
                start_node = i;
                break;
            }
        }

        if (start_node == -1) return 0;

        vector<int> visited(n + 1, 0);
        vector<int> path;

        function<void(int)> dfs = [&](int u) {
            visited[u] = 1;
            path.push_back(u);
            for (int v : adj[u]) {
                if (!visited[v]) {
                    dfs(v);
                }
            }
        };

        dfs(start_node);

        if (path.size() != n) return 0;

        return 1;
    }
};