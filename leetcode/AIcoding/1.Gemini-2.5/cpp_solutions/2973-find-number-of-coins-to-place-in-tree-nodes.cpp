#include <vector>
#include <algorithm>
#include <numeric>

std::vector<long long> dfs(int u, int p, const std::vector<std::vector<int>>& adj, const std::vector<int>& cost, std::vector<long long>& ans) {
    std::vector<long long> subtree_values;
    subtree_values.push_back(cost[u]);

    for (int v : adj[u]) {
        if (v == p) {
            continue;
        }
        std::vector<long long> child_subtree_values = dfs(v, u, adj, cost, ans);
        subtree_values.insert(subtree_values.end(), child_subtree_values.begin(), child_subtree_values.end());
    }

    // Sort all values collected from current node and its children's subtrees
    std::sort(subtree_values.begin(), subtree_values.end());

    // Trim the vector to keep only the 2 smallest and 3 largest values.
    // These are the only candidates for forming the maximum product of three.
    // If the size is 5 or less, we keep all of them.
    if (subtree_values.size() > 5) {
        std::vector<long long> trimmed_values;
        trimmed_values.push_back(subtree_values[0]); // Smallest
        trimmed_values.push_back(subtree_values[1]); // Second smallest
        trimmed_values.push_back(subtree_values[subtree_values.size() - 3]); // Third largest
        trimmed_values.push_back(subtree_values[subtree_values.size() - 2]); // Second largest
        trimmed_values.push_back(subtree_values[subtree_values.size() - 1]); // Largest
        subtree_values = trimmed_values;
    }

    // Calculate the number of coins for node u
    if (subtree_values.size() < 3) {
        ans[u] = 1; // Less than 3 nodes in the subtree, so 1 coin
    } else {
        long long max_product = 0; // Initialize to 0, as negative products result in 0 coins
        int n_vals = subtree_values.size();

        // Potential product 1: Three largest values (e.g., 3 * 2 * 1)
        max_product = std::max(max_product, subtree_values[n_vals - 1] * subtree_values[n_vals - 2] * subtree_values[n_vals - 3]);

        // Potential product 2: Largest value and the two smallest values
        // This is relevant if the two smallest values are negative (e.g., 3 * (-10) * (-5) = 150)
        max_product = std::max(max_product, subtree_values[n_vals - 1] * subtree_values[0] * subtree_values[1]);

        ans[u] = max_product;
    }

    return subtree_values;
}

class Solution {
public:
    std::vector<long long> numberOfCoins(int n, std::vector<std::vector<int>>& edges, std::vector<int>& cost) {
        std::vector<std::vector<int>> adj(n);
        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        std::vector<long long> ans(n);
        // Start DFS from node 0 (arbitrary root for a tree), with -1 as parent to signify no parent
        dfs(0, -1, adj, cost, ans); 

        return ans;
    }
};