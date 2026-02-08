#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximizeTheMinScore(int n, vector<vector<int>>& edges) {
        vector<int> parent(n);
        for (int i = 0; i < n; ++i) {
            parent[i] = i;
        }

        auto find = [&](int u) {
            while (parent[u] != u) {
                parent[u] = parent[parent[u]];
                u = parent[u];
            }
            return u;
        };

        auto unite = [&](int u, int v) {
            int pu = find(u);
            int pv = find(v);
            if (pu != pv) {
                parent[pv] = pu;
            }
        };

        for (auto& edge : edges) {
            unite(edge[0], edge[1]);
        }

        vector<int> minScore(n, INT_MAX);
        for (auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];
            int root = find(u);
            minScore[root] = min(minScore[root], w);
        }

        int res = INT_MAX;
        for (int i = 0; i < n; ++i) {
            if (parent[i] == i && minScore[i] != INT_MAX) {
                res = min(res, minScore[i]);
            }
        }

        return res;
    }
};