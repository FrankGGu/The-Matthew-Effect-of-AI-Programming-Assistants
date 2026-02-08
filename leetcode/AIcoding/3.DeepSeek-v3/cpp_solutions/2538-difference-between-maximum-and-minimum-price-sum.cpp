#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    long long maxOutput(int n, vector<vector<int>>& edges, vector<int>& price) {
        vector<vector<int>> adj(n);
        for (const auto& e : edges) {
            adj[e[0]].push_back(e[1]);
            adj[e[1]].push_back(e[0]);
        }

        long long res = 0;
        function<pair<long long, long long>(int, int)> dfs = [&](int u, int parent) {
            long long max1 = price[u], max2 = 0;
            for (int v : adj[u]) {
                if (v == parent) continue;
                auto [child_max1, child_max2] = dfs(v, u);
                res = max(res, max(max1 + child_max2, max2 + child_max1));
                max1 = max(max1, child_max1 + price[u]);
                max2 = max(max2, child_max2 + price[u]);
            }
            return make_pair(max1, max2);
        };

        dfs(0, -1);
        return res;
    }
};