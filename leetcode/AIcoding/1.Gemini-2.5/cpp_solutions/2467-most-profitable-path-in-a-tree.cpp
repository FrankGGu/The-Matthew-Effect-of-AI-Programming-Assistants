#include <vector>
#include <numeric>
#include <algorithm>
#include <limits> // For std::numeric_limits

class Solution {
public:
    std::vector<std::vector<int>> adj;
    std::vector<int> amount_val;
    std::vector<long long> sum_full_val; // Sum of amount[v] for v on path 0->u
    std::vector<long long> sum_half_val; // Sum of amount[v]/2 for v on path 0->u
    long long max_profit;
    int N;

    void dfs_precompute_sums(int u, int p, long long current_sum_full, long long current_sum_half) {
        sum_full_val[u] = current_sum_full + amount_val[u];
        sum_half_val[u] = current_sum_half + amount_val[u] / 2;

        for (int v : adj[u]) {
            if (v == p) continue;
            dfs_precompute_sums(v, u, sum_full_val[u], sum_half_val[u]);
        }
    }

    void dfs_find_max_profit(int u, int p, long long min_half_sum_on_path) {
        // current_min_half_sum_for_u is the minimum sum_half_val[v] for v on path 0->u (inclusive)
        long long current_min_half_sum_for_u = std::min(min_half_sum_on_path, sum_half_val[u]);

        bool is_leaf = true;
        for (int v : adj[u]) {
            if (v == p) continue;
            is_leaf = false;
            dfs_find_max_profit(v, u, current_min_half_sum_for_u);
        }

        if (is_leaf) { // If u is a leaf node (a node with no children other than its parent in the DFS tree)
            max_profit = std::max(max_profit, sum_full_val[u] - current_min_half_sum_for_u);
        }
    }

    int mostProfitablePath(std::vector<std::vector<int>>& edges, std::vector<int>& amount) {
        N = amount.size();
        adj.resize(N);
        amount_val = amount;
        sum_full_val.resize(N);
        sum_half_val.resize(N);
        max_profit = std::numeric_limits<long long>::min(); // Initialize with smallest possible long long

        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        // Special case for N=1: node 0 is the only node, it's a leaf.
        // Alice goes 0->0, Bob goes 0->0. Shared node 0. Profit amount[0]/2.
        if (N == 1) {
            return amount[0] / 2;
        }

        // Step 1: Precompute prefix sums for full amount and half amount
        // This DFS calculates sum_full_val[u] and sum_half_val[u] for all nodes u,
        // representing the sum of amounts (or half amounts) on the unique path from 0 to u.
        dfs_precompute_sums(0, -1, 0, 0);

        // Step 2: Find the maximum profit for Bob
        // This DFS iterates through all possible Bob's paths (from 0 to any leaf).
        // For each node u on Bob's path, it considers all possible Alice's paths
        // by finding the minimum sum_half_val for any common ancestor X.
        // Passing LLONG_MAX for the parent of node 0 ensures that min(LLONG_MAX, sum_half_val[0])
        // correctly initializes the minimum half sum for the path starting at 0.
        dfs_find_max_profit(0, -1, std::numeric_limits<long long>::max());

        return static_cast<int>(max_profit);
    }
};