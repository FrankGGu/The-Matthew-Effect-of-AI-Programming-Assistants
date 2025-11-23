#include <vector>

using namespace std;

class Solution {
public:
    int maxKDivisibleComponents(int n, vector<vector<int>>& edges, vector<int>& values, int k) {
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<bool> visited(n, false);
        int count = 0;

        function<long long(int)> dfs = [&](int u) {
            visited[u] = true;
            long long sum = values[u];
            for (int v : adj[u]) {
                if (!visited[v]) {
                    sum += dfs(v);
                }
            }
            return sum;
        };

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                if (dfs(i) % k == 0) {
                    count++;
                }
            }
        }

        return count;
    }
};