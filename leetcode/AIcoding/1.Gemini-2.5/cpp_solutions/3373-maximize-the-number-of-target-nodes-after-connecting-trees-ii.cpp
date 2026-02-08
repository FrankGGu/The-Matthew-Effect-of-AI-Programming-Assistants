#include <vector>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> adj;
    std::vector<int> target_nodes;
    // dp[u][0]: Minimum operations to connect all target nodes in u's subtree,
    //           such that u is NOT connected to its parent.
    // dp[u][1]: Minimum operations to connect all target nodes in u's subtree,
    //           such that u IS connected to its parent.
    std::vector<std::vector<int>> dp; 

    // has_target_in_subtree_cache[u]: true if node u or any node in its subtree is a target node.
    std::vector<bool> has_target_in_subtree_cache;

    const int INF = 1e9 + 7; // A large value to represent infinity

    void dfs(int u, int p) {
        bool current_node_is_target = (target_nodes[u] == 1);
        has_target_in_subtree_cache[u] = current_node_is_target;

        int sum_dp0_children = 0;
        int min_delta_to_connect_up = INF; // Minimum (dp[v][1] - dp[v][0]) among children v

        for (int v : adj[u]) {
            if (v == p) {
                continue;
            }
            dfs(v, u);
            has_target_in_subtree_cache[u] |= has_target_in_subtree_cache[v];
            sum_dp0_children += dp[v][0];
            min_delta_to_connect_up = std::min(min_delta_to_connect_up, dp[v][1] - dp[v][0]);
        }

        // If no target nodes exist in the subtree rooted at u (including u itself)
        if (!has_target_in_subtree_cache[u]) {
            dp[u][0] = 0;
            dp[u][1] = INF; // Cannot connect upwards if no target nodes
            return;
        }

        // Calculate dp[u][0] (u is not connected to its parent)
        // All target nodes in u's subtree must be connected among themselves.
        if (current_node_is_target) {
            // If u is a target node, it can connect to all its children's target components for free
            // (via existing edges to non-target children, or directly to target children).
            dp[u][0] = sum_dp0_children;
        } else { // u is a non-target node
            // If u is a non-target node, it must be activated (cost 1) to connect its children's target components.
            dp[u][0] = sum_dp0_children + 1;
        }

        // Calculate dp[u][1] (u is connected to its parent)
        // u is connected to its parent, meaning it's part of a larger target-connected component.
        // It needs to connect all its children's target components.
        // At least one child v must connect upwards to u (i.e., v is in state dp[v][1]).
        // Other children can be in state dp[v][0].
        // The cost for this is sum_dp0_children (all children initially in state 0)
        // plus min_delta_to_connect_up (cost to switch one child from state 0 to state 1).
        // If u is non-target, it's considered "activated" by its parent, so no additional cost for u itself.
        if (min_delta_to_connect_up == INF) {
            dp[u][1] = INF; // Cannot connect upwards if no child can connect to u
        } else {
            dp[u][1] = sum_dp0_children + min_delta_to_connect_up;
        }
    }

    int maximizeTheNumberOfTargetNodesAfterConnectingTreesII(int n, std::vector<std::vector<int>>& edges, std::vector<int>& target) {
        adj.resize(n);
        target_nodes = target;
        dp.assign(n, std::vector<int>(2));
        has_target_in_subtree_cache.assign(n, false);

        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        // Start DFS from node 0 (arbitrary root, parent -1)
        dfs(0, -1);

        // The final answer is dp[0][0] because the root node (0) cannot be connected to a parent.
        return dp[0][0];
    }
};