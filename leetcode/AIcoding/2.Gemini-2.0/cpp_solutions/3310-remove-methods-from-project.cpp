#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> removeMethods(int n, vector<vector<int>>& methods, vector<int>& dependencies) {
        vector<int> inDegree(n, 0);
        vector<vector<int>> adj(n);
        for (auto& dependency : dependencies) {
            inDegree[dependency]++;
        }

        for (auto& method : methods) {
            adj[method[0]].push_back(method[1]);
        }

        vector<int> removed;
        vector<bool> visited(n, false);

        function<void(int)> dfs = [&](int u) {
            visited[u] = true;
            removed.push_back(u);
            for (int v : adj[u]) {
                if (!visited[v]) {
                    dfs(v);
                }
            }
        };

        for (int i = 0; i < n; ++i) {
            if (inDegree[i] == 0 && !visited[i]) {
                dfs(i);
            }
        }

        sort(removed.begin(), removed.end());
        return removed;
    }
};