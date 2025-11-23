#include <vector>
#include <algorithm>
#include <climits>

class Solution {
public:
    int maximumPoints(std::vector<std::vector<int>>& edges, std::vector<int>& coins, int k) {
        int n = coins.size();
        adj.assign(n, std::vector<int>());
        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        this->c = coins;
        this->K = k;
        memo.assign(n, std::vector<int>(MAX_SHIFT + 1, INT_MIN));

        return dfs(0, -1, 0);
    }

private:
    std::vector<std::vector<int>> adj;
    std::vector<int> c;
    int K;
    std::vector<std::vector<int>> memo;
    const int MAX_SHIFT = 14;

    int dfs(int u, int p, int shift) {
        if (shift > MAX_SHIFT) {
            return 0;
        }
        if (memo[u][shift] != INT_MIN) {
            return memo[u][shift];
        }

        int val = c[u] >> shift;

        int option1 = val - K;
        for (int v : adj[u]) {
            if (v != p) {
                option1 += dfs(v, u, shift);
            }
        }

        int option2 = val / 2;
        for (int v : adj[u]) {
            if (v != p) {
                option2 += dfs(v, u, shift + 1);
            }
        }

        return memo[u][shift] = std::max(option1, option2);
    }
};