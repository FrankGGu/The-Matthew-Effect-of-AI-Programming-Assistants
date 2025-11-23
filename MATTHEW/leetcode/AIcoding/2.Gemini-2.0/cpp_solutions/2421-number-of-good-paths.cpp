#include <vector>
#include <numeric>

using namespace std;

class Solution {
public:
    int numberOfGoodPaths(vector<int>& vals, vector<vector<int>>& edges) {
        int n = vals.size();
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            int u = edge[0], v = edge[1];
            adj[u].push_back(v);
            adj[v].push_back(u);
        }

        vector<int> parent(n);
        iota(parent.begin(), parent.end(), 0);

        function<int(int)> find = [&](int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        };

        auto unite = [&](int x, int y) {
            int rootX = find(x);
            int rootY = find(y);
            if (rootX != rootY) {
                parent[rootX] = rootY;
            }
        };

        vector<pair<int, int>> nodes(n);
        for (int i = 0; i < n; ++i) {
            nodes[i] = {vals[i], i};
        }
        sort(nodes.begin(), nodes.end());

        long long ans = n;
        vector<int> count(n, 0);

        for (auto& node : nodes) {
            int val = node.first, u = node.second;
            count[u] = 1;
            for (int v : adj[u]) {
                if (vals[v] <= val && count[v] > 0) {
                    int rootU = find(u);
                    int rootV = find(v);
                    if (rootU != rootV) {
                        ans += (long long)count[rootU] * count[rootV];
                        unite(u, v);
                        count[find(u)] = count[rootU] + count[rootV];
                    }
                }
            }
        }

        return ans;
    }
};