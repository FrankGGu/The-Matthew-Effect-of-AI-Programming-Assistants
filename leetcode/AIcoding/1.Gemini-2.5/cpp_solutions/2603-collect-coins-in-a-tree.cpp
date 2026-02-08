#include <vector>
#include <queue>
#include <numeric>
#include <algorithm>

class Solution {
public:
    int collectTheCoins(std::vector<int>& coins, std::vector<std::vector<int>>& edges) {
        int n = coins.size();
        if (n <= 1) {
            return 0;
        }

        std::vector<std::vector<int>> adj(n);
        std::vector<int> degree(n, 0);

        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
            degree[edge[0]]++;
            degree[edge[1]]++;
        }

        // Phase 1: Prune all leaves that do not have coins.
        // Repeat until no such leaves exist.
        std::queue<int> q;
        for (int i = 0; i < n; ++i) {
            if (degree[i] == 1 && coins[i] == 0) {
                q.push(i);
            }
        }

        int remaining_nodes = n;
        std::vector<bool> removed(n, false);

        while (!q.empty()) {
            int u = q.front();
            q.pop();

            if (removed[u]) continue; // Already processed
            removed[u] = true;
            remaining_nodes--;

            for (int v : adj[u]) {
                if (!removed[v]) {
                    degree[v]--;
                    if (degree[v] == 1 && coins[v] == 0) {
                        q.push(v);
                    }
                }
            }
        }

        // Phase 2: After the first pruning, all remaining leaves must have coins.
        // We now need to remove the outermost two layers of nodes from the remaining tree.
        // This is because to collect a coin at a leaf, we must traverse the edge to it.
        // To traverse that edge, we must be at its parent. The parent might be a leaf
        // of the remaining tree itself. We need to effectively "cut off" the branches
        // that are only 1 or 2 edges away from a coin and don't lead to other coins.

        // Re-initialize queue with current leaves (degree 1 nodes that are not removed)
        // These leaves are guaranteed to have coins (or lead to coins if they were not removed in phase 1).
        // If a node was removed, its degree is effectively 0 for the remaining graph.
        std::queue<int> q2;
        for (int i = 0; i < n; ++i) {
            if (!removed[i] && degree[i] == 1) {
                q2.push(i);
            }
        }

        // Perform BFS for 2 levels
        for (int level = 0; level < 2 && !q2.empty(); ++level) {
            int level_size = q2.size();
            for (int i = 0; i < level_size; ++i) {
                int u = q2.front();
                q2.pop();

                if (removed[u]) continue; // Should not happen if logic is correct
                removed[u] = true;
                remaining_nodes--;

                for (int v : adj[u]) {
                    if (!removed[v]) {
                        degree[v]--;
                        if (degree[v] == 1) { // Now, any new leaf (degree 1) is added
                            q2.push(v);
                        }
                    }
                }
            }
        }

        // The remaining_nodes count now represents the number of nodes in the "core" tree
        // that must be traversed. If there are `k` nodes in this core tree, it has `k-1` edges
        // (assuming it's connected). To traverse all these edges to collect coins, we need to
        // traverse each edge twice (once down, once up).
        // If remaining_nodes is 0 or 1, no edges are traversed.
        if (remaining_nodes <= 1) {
            return 0;
        } else {
            return 2 * (remaining_nodes - 1);
        }
    }
};