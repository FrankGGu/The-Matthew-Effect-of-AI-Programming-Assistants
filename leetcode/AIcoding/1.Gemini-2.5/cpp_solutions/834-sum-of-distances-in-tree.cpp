#include <vector>
#include <numeric>

class Solution {
public:
    int N;
    std::vector<std::vector<int>> adj;
    std::vector<int> count;
    std::vector<int> ans;

    void dfs1(int u, int p) {
        count[u] = 1;
        ans[u] = 0;
        for (int v : adj[u]) {
            if (v == p) {
                continue;
            }
            dfs1(v, u);
            count[u] += count[v];
            ans[u] += ans[v] + count[v];
        }
    }

    void dfs2(int u, int p) {
        for (int v : adj[u]) {
            if (v == p) {
                continue;
            }
            ans[v] = ans[u] - count[v] + (N - count[v]);
            dfs2(v, u);
        }
    }

    std::vector<int> sumOfDistancesInTree(int n, std::vector<std::vector<int>>& edges) {
        N = n;
        adj.resize(N);
        count.resize(N);
        ans.resize(N);

        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        dfs1(0, -1);
        dfs2(0, -1);

        return ans;
    }
};