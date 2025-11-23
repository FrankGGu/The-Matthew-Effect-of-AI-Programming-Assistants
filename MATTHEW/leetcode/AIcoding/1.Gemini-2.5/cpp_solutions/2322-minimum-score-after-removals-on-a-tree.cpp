#include <vector>
#include <numeric>
#include <algorithm>
#include <climits>

class Solution {
public:
    std::vector<std::vector<int>> adj;
    std::vector<int> node_values;
    std::vector<int> dfs_xor_sums;
    std::vector<int> tin, tout;
    int timer;

    void dfs(int u, int p) {
        tin[u] = timer++;
        dfs_xor_sums[u] = node_values[u];
        for (int v : adj[u]) {
            if (v == p) {
                continue;
            }
            dfs(v, u);
            dfs_xor_sums[u] ^= dfs_xor_sums[v];
        }
        tout[u] = timer++;
    }

    bool is_ancestor(int u, int v) {
        return tin[u] <= tin[v] && tout[u] >= tout[v];
    }

    int minimumScore(std::vector<int>& values, std::vector<std::vector<int>>& edges) {
        int n = values.size();
        node_values = values;

        adj.resize(n);
        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        dfs_xor_sums.resize(n);
        tin.resize(n);
        tout.resize(n);
        timer = 0;

        dfs(0, -1); // Start DFS from node 0, with no parent

        int total_xor_sum = dfs_xor_sums[0];
        int min_score = INT_MAX;

        // Iterate over all possible pairs of edges to remove
        // An edge (p, c) is identified by its child node 'c'.
        // We iterate over all possible distinct 'c1' and 'c2' (which are not the root).
        for (int i = 1; i < n; ++i) { // Node 'i' represents the child of the first cut edge
            for (int j = i + 1; j < n; ++j) { // Node 'j' represents the child of the second cut edge
                int x1, x2, x3;

                // Case 1: Node 'i' is an ancestor of node 'j' (or 'j' is in subtree of 'i')
                if (is_ancestor(i, j)) {
                    // Cut edge (parent[i], i) and (parent[j], j)
                    // Component 1: subtree rooted at j (dfs_xor_sums[j])
                    // Component 2: subtree rooted at i, excluding subtree rooted at j (dfs_xor_sums[i] ^ dfs_xor_sums[j])
                    // Component 3: rest of the tree (total_xor_sum ^ dfs_xor_sums[i])
                    x1 = dfs_xor_sums[j];
                    x2 = dfs_xor_sums[i] ^ x1;
                    x3 = total_xor_sum ^ dfs_xor_sums[i];
                }
                // Case 2: Node 'j' is an ancestor of node 'i' (or 'i' is in subtree of 'j')
                else if (is_ancestor(j, i)) {
                    // Cut edge (parent[j], j) and (parent[i], i)
                    // Component 1: subtree rooted at i (dfs_xor_sums[i])
                    // Component 2: subtree rooted at j, excluding subtree rooted at i (dfs_xor_sums[j] ^ dfs_xor_sums[i])
                    // Component 3: rest of the tree (total_xor_sum ^ dfs_xor_sums[j])
                    x1 = dfs_xor_sums[i];
                    x2 = dfs_xor_sums[j] ^ x1;
                    x3 = total_xor_sum ^ dfs_xor_sums[j];
                }
                // Case 3: 'i' and 'j' are in different subtrees (neither is an ancestor of the other)
                else {
                    // Cut edge (parent[i], i) and (parent[j], j)
                    // Component 1: subtree rooted at i (dfs_xor_sums[i])
                    // Component 2: subtree rooted at j (dfs_xor_sums[j])
                    // Component 3: rest of the tree (total_xor_sum ^ dfs_xor_sums[i] ^ dfs_xor_sums[j])
                    x1 = dfs_xor_sums[i];
                    x2 = dfs_xor_sums[j];
                    x3 = total_xor_sum ^ x1 ^ x2;
                }

                int current_max = std::max({x1, x2, x3});
                int current_min = std::min({x1, x2, x3});
                min_score = std::min(min_score, current_max - current_min);
            }
        }

        return min_score;
    }
};