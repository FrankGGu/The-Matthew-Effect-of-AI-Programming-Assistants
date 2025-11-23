#include <vector>

using namespace std;

class Solution {
public:
    vector<int> countSubtrees(int n, vector<vector<int>>& edges, string labels) {
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<int> ans(n);
        vector<bool> visited(n, false);

        function<vector<int>(int)> dfs = [&](int u) {
            visited[u] = true;
            vector<int> counts(26, 0);
            counts[labels[u] - 'a'] = 1;

            for (int v : adj[u]) {
                if (!visited[v]) {
                    vector<int> childCounts = dfs(v);
                    for (int i = 0; i < 26; ++i) {
                        counts[i] += childCounts[i];
                    }
                }
            }

            ans[u] = counts[labels[u] - 'a'];
            return counts;
        };

        dfs(0);
        return ans;
    }
};