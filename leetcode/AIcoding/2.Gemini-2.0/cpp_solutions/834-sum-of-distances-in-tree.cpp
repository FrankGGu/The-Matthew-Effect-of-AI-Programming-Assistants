#include <vector>

using namespace std;

class Solution {
public:
    vector<int> sumOfDistancesInTree(int n, vector<vector<int>>& edges) {
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<int> count(n, 1);
        vector<int> ans(n, 0);

        function<void(int, int)> dfs1 = [&](int u, int p) {
            for (int v : adj[u]) {
                if (v != p) {
                    dfs1(v, u);
                    count[u] += count[v];
                    ans[u] += ans[v] + count[v];
                }
            }
        };

        dfs1(0, -1);

        function<void(int, int)> dfs2 = [&](int u, int p) {
            for (int v : adj[u]) {
                if (v != p) {
                    ans[v] = ans[u] - count[v] + (n - count[v]);
                    dfs2(v, u);
                }
            }
        };

        dfs2(0, -1);

        return ans;
    }
};