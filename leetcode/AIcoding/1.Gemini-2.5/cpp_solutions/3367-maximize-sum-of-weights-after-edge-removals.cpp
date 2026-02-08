#include <vector>
#include <numeric>
#include <cmath>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> adj;
    std::vector<long long> subtree_sum;
    const std::vector<int>* weights_ptr;

    long long dfs(int u, int p) {
        long long current_subtree_total = (*weights_ptr)[u];

        for (int v : adj[u]) {
            if (v == p) {
                continue;
            }
            current_subtree_total += dfs(v, u);
        }
        subtree_sum[u] = current_subtree_total;
        return current_subtree_total;
    }

    long long maximizeSumOfWeights(int n, std::vector<std::vector<int>>& edges, std::vector<int>& weights) {
        adj.resize(n);
        subtree_sum.resize(n);
        weights_ptr = &weights;

        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        long long total_sum = 0;
        for (int weight : weights) {
            total_sum += weight;
        }

        dfs(0, -1);

        long long max_diff = 0;

        for (int i = 0; i < n; ++i) {
            max_diff = std::max(max_diff, std::llabs(2 * subtree_sum[i] - total_sum));
        }

        return max_diff;
    }
};