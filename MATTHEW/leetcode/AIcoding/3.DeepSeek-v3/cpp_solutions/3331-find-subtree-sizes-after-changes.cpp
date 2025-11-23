#include <vector>
#include <functional>
using namespace std;

class Solution {
public:
    vector<int> subtreeSizes(int n, vector<vector<int>>& edges, vector<vector<int>>& changes) {
        vector<vector<int>> graph(n);
        for (auto& e : edges) {
            graph[e[0]].push_back(e[1]);
            graph[e[1]].push_back(e[0]);
        }

        vector<int> parent(n, -1), size(n, 1);
        function<void(int, int)> dfs = [&](int u, int p) {
            parent[u] = p;
            for (int v : graph[u]) {
                if (v == p) continue;
                dfs(v, u);
                size[u] += size[v];
            }
        };
        dfs(0, -1);

        vector<int> res;
        for (auto& c : changes) {
            int u = c[0], v = c[1];
            if (parent[u] == v) swap(u, v);
            if (parent[v] != u) {
                res.push_back(size[0]);
                continue;
            }

            int cur = u;
            while (cur != -1) {
                size[cur] -= size[v];
                cur = parent[cur];
            }

            parent[v] = -1;
            cur = u;
            while (cur != -1) {
                size[cur] += size[v];
                cur = parent[cur];
            }

            parent[v] = u;
            res.push_back(size[0]);
        }
        return res;
    }
};