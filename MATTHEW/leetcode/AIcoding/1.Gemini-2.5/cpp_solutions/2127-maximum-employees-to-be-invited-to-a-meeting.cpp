#include <vector>
#include <numeric>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> favorite;
    vector<int> visited; // 0: unvisited, 1: visiting (in current path), 2: visited (processed)
    vector<int> path_len; // distance from current DFS start node
    vector<bool> is_on_cycle; // true if node is part of any cycle
    vector<vector<int>> rev_adj; // reversed graph for in-trees
    vector<int> memo_tree_depth; // memoization for get_tree_depth

    // This function calculates the length of the longest path of non-cycle nodes
    // ending at 'u' in the reversed graph.
    // If 'u' is on a cycle, it acts as a base case, returning 0 as it's the "root"
    // of the in-tree, not part of its length.
    int get_tree_depth(int u) {
        if (memo_tree_depth[u] != -1) {
            return memo_tree_depth[u];
        }

        // If 'u' is on a cycle, it's a base case for the tree depth calculation.
        // Paths leading to it end here (as far as non-cycle nodes are concerned).
        // Its own contribution to the tree length is 0, as it's part of the cycle itself.
        if (is_on_cycle[u]) {
            return memo_tree_depth[u] = 0;
        }

        int max_prev_depth = 0;
        for (int prev_node : rev_adj[u]) {
            // Only consider predecessors that are NOT on any cycle to extend the tree path.
            // If prev_node is on a cycle, it means 'u' is part of a path leading into that cycle,
            // but 'prev_node' itself is part of another cycle (or the same cycle if it's a 2-cycle,
            // but that case is handled by the `is_on_cycle` check for `u` itself).
            // We are looking for paths of nodes that are *not* on cycles.
            if (!is_on_cycle[prev_node]) {
                max_prev_depth = max(max_prev_depth, get_tree_depth(prev_node));
            }
        }
        // 1 for 'u' itself, plus the maximum depth from its non-cycle predecessors.
        return memo_tree_depth[u] = 1 + max_prev_depth;
    }

    int maximumInvitations(vector<int>& favorite_input) {
        favorite = favorite_input;
        int n = favorite.size();

        visited.assign(n, 0);
        path_len.assign(n, 0);
        is_on_cycle.assign(n, false);
        rev_adj.assign(n, vector<int>());
        memo_tree_depth.assign(n, -1);

        // 1. Build reversed adjacency list
        for (int i = 0; i < n; ++i) {
            rev_adj[favorite[i]].push_back(i);
        }

        int max_long_cycle_len = 0;

        // 2. Cycle detection and mark nodes on cycles
        for (int i = 0; i < n; ++i) {
            if (visited[i] == 0) {
                int curr = i;
                int depth = 0;
                vector<int> path_nodes_in_dfs;

                // Traverse until we hit an already visited node
                while (visited[curr] == 0) {
                    visited[curr] = 1; // Mark as visiting (in current path)
                    path_len[curr] = depth;
                    path_nodes_in_dfs.push_back(curr);
                    curr = favorite[curr];
                    depth++;
                }

                if (visited[curr] == 1) { // Cycle detected (hit a node currently in DFS path)
                    int cycle_start_depth = path_len[curr];
                    int cycle_len = depth - cycle_start_depth;

                    // Mark all nodes in the detected cycle as 'is_on_cycle = true'
                    for (int k = cycle_start_depth; k < depth; ++k) {
                        is_on_cycle[path_nodes_in_dfs[k]] = true;
                    }

                    if (cycle_len >= 3) {
                        max_long_cycle_len = max(max_long_cycle_len, cycle_len);
                    }
                }

                // Mark all nodes in the current DFS path as fully visited (processed)
                for (int node : path_nodes_in_dfs) {
                    visited[node] = 2;
                }
            }
        }

        // Initialize memo_tree_depth for nodes that are on any cycle.
        // These nodes are the "roots" of the in-trees, so their contribution to tree length is 0.
        for (int i = 0; i < n; ++i) {
            if (is_on_cycle[i]) {
                memo_tree_depth[i] = 0;
            }
        }

        // Calculate tree depths for all nodes not on cycles using memoized DFS.
        // This ensures all `memo_tree_depth` values are computed.
        for (int i = 0; i < n; ++i) {
            if (memo_tree_depth[i] == -1) { // If not on cycle and not calculated yet
                get_tree_depth(i);
            }
        }

        long long total_two_cycle_tree_len = 0;

        // 3. Calculate total length for 2-cycles with attached trees
        for (int i = 0; i < n; ++i) {
            // Check if 'i' is part of a 2-cycle (i <-> favorite[i]) and process each 2-cycle only once.
            // The condition `i < favorite[i]` ensures we process (i, j) but not (j, i).
            if (is_on_cycle[i] && favorite[favorite[i]] == i && i < favorite[i]) {
                int j = favorite[i]; // The other node in the 2-cycle

                long long current_2_cycle_total = 2; // For 'i' and 'j' themselves

                // Add depths of trees leading to 'i' (excluding 'j' itself)
                for (int node_leading_to_i : rev_adj[i]) {
                    if (node_leading_to_i != j) { // Exclude the other node of the 2-cycle
                        current_2_cycle_total += get_tree_depth(node_leading_to_i);
                    }
                }

                // Add depths of trees leading to 'j' (excluding 'i' itself)
                for (int node_leading_to_j : rev_adj[j]) {
                    if (node_leading_to_j != i) { // Exclude the other node of the 2-cycle
                        current_2_cycle_total += get_tree_depth(node_leading_to_j);
                    }
                }
                total_two_cycle_tree_len += current_2_cycle_total;
            }
        }

        // The maximum number of invitations is the maximum of:
        // 1. The length of the longest cycle of length >= 3.
        // 2. The total sum of nodes in all 2-cycles and their attached in-trees.
        return max((long long)max_long_cycle_len, total_two_cycle_tree_len);
    }
};