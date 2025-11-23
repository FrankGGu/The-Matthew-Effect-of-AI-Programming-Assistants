#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxProfit(int n, vector<int>& price, vector<vector<int>>& edges) {
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<long long> subtree_max(n, 0);
        vector<long long> subtree_no_root_max(n, 0);

        function<void(int, int)> dfs = [&](int u, int parent) {
            subtree_max[u] = price[u];
            subtree_no_root_max[u] = 0;

            for (int v : adj[u]) {
                if (v != parent) {
                    dfs(v, u);
                    subtree_max[u] += max(0LL, subtree_max[v]);
                    subtree_no_root_max[u] += max(0LL, subtree_max[v]);
                }
            }
        };

        dfs(0, -1);

        long long ans = 0;
        function<void(int, int, long long, long long)> reroot = [&](int u, int parent, long long parent_subtree_max, long long parent_subtree_no_root_max) {
            ans = max(ans, subtree_max[u] + parent_subtree_no_root_max);

            for (int v : adj[u]) {
                if (v != parent) {
                    long long old_subtree_max_u = subtree_max[u];
                    long long old_subtree_no_root_max_u = subtree_no_root_max[u];

                    subtree_max[u] -= max(0LL, subtree_max[v]);
                    subtree_no_root_max[u] -= max(0LL, subtree_max[v]);

                    reroot(v, u, max(0LL, subtree_max[u] + parent_subtree_max), max(0LL, subtree_max[u] + parent_subtree_max - price[u]));

                    subtree_max[u] = old_subtree_max_u;
                    subtree_no_root_max[u] = old_subtree_no_root_max_u;
                }
            }
        };

        reroot(0, -1, 0, 0);

        return ans;
    }
};