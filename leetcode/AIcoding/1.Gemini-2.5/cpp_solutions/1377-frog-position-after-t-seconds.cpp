#include <vector>
#include <numeric>

class Solution {
public:
    std::vector<std::vector<int>> adj;
    int T_max;
    int Target_node;
    double final_prob = 0.0;

    void dfs(int u, int p, int current_time, double prob) {
        // If current time exceeds the maximum allowed time, this path is invalid.
        if (current_time > T_max) {
            return;
        }

        // If the current node is the target node
        if (u == Target_node) {
            // Case 1: Reached the target node exactly at T_max seconds.
            // This is a valid final position.
            if (current_time == T_max) {
                final_prob = prob;
                return;
            }
            // Case 2: Reached the target node before T_max seconds.
            if (current_time < T_max) {
                // Count the number of valid next jumps (neighbors other than the parent).
                int num_next_jumps = 0;
                for (int v : adj[u]) {
                    if (v != p) {
                        num_next_jumps++;
                    }
                }
                // If there are no further jumps possible, the frog stays at this node
                // until T_max. This is a valid final position.
                if (num_next_jumps == 0) {
                    final_prob = prob;
                }
                // If num_next_jumps > 0, the frog must jump. Thus, this specific path
                // to the target node at `current_time` is not the final one for `T_max`.
                // We do not set final_prob here. In either subcase (stay or jump),
                // we stop exploring this particular path from `u` because we've determined
                // its fate regarding the target.
                return;
            }
        }

        // If current time is T_max and we are not at the target node,
        // this path does not lead to the target at the correct time.
        if (current_time == T_max) {
            return;
        }

        // Count the number of valid next jumps (neighbors other than the parent).
        int num_next_jumps = 0;
        for (int v : adj[u]) {
            if (v != p) {
                num_next_jumps++;
            }
        }

        // If there are no further jumps, the frog stays at this node.
        // Since `u` is not the target (or if it was, it was handled above),
        // this path does not contribute to `final_prob`.
        if (num_next_jumps == 0) {
            return;
        }

        // The frog must jump to one of the unvisited neighbors.
        // Divide the current probability equally among the possible next jumps.
        for (int v : adj[u]) {
            if (v != p) {
                dfs(v, u, current_time + 1, prob / num_next_jumps);
            }
        }
    }

    double frogPosition(int n, std::vector<std::vector<int>>& edges, int t, int target) {
        adj.resize(n + 1);
        T_max = t;
        Target_node = target;

        // Build the adjacency list for the graph.
        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        // Start the Depth-First Search from node 1 (frog's starting position),
        // with a dummy parent 0, initial time 0, and initial probability 1.0.
        dfs(1, 0, 0, 1.0);

        return final_prob;
    }
};