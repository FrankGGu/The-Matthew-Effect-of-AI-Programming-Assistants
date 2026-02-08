#include <vector>
#include <numeric>
#include <algorithm> // For std::max, std::min
#include <climits>   // For LLONG_MAX

class Solution {
public:
    std::vector<std::vector<long long>> dp; // dp[u][0] = max score from subtree u if u is NOT chosen
                                            // dp[u][1] = max score from subtree u if u IS chosen
    std::vector<std::vector<int>> adj;
    const std::vector<int>* values_ptr; // Pointer to original values vector for convenience

    void dfs(int u, int p) {
        bool is_leaf = true;
        long long sum_max_child_scores = 0;
        long long min_cost_to_pick_child = LLONG_MAX; // Represents min(dp[v][0] - dp[v][1]) for children v
        bool has_chosen_child_preferred = false; // True if any child v has dp[v][1] > dp[v][0]

        for (int v : adj[u]) {
            if (v == p) {
                continue;
            }
            is_leaf = false; // u has at least one child
            dfs(v, u);

            sum_max_child_scores += std::max(dp[v][0], dp[v][1]);

            if (dp[v][1] > dp[v][0]) {
                has_chosen_child_preferred = true;
            }
            min_cost_to_pick_child = std::min(min_cost_to_pick_child, dp[v][0] - dp[v][1]);
        }

        if (is_leaf) {
            // If u is a leaf node, it can be chosen (score values[u]) or not chosen (score 0).
            dp[u][1] = (*values_ptr)[u];
            dp[u][0] = 0;
            return;
        }

        // Calculate dp[u][0] (u is NOT chosen)
        // If u is not chosen, its children can be chosen or not chosen independently.
        // We take the maximum possible score from each child's subtree.
        dp[u][0] = sum_max_child_scores;

        // Calculate dp[u][1] (u IS chosen)
        // If u is chosen, we add values[u] to the score.
        // Then, for its children, we sum up max(dp[v][0], dp[v][1]).
        // However, there's a constraint: if u is not a leaf, we must choose at least one of its children.
        long long current_score_if_u_chosen = (*values_ptr)[u] + sum_max_child_scores;

        if (!has_chosen_child_preferred) {
            // If no child preferred to be picked (i.e., for all children v, dp[v][0] >= dp[v][1]),
            // we must force one child to be picked.
            // To minimize the penalty (or maximize the score), we choose the child that has the smallest
            // difference (dp[v][0] - dp[v][1]). This difference is `min_cost_to_pick_child`.
            // Subtracting this value effectively changes `max(dp[v][0], dp[v][1])` to `dp[v][1]` for that child.
            current_score_if_u_chosen -= min_cost_to_pick_child;
        }
        dp[u][1] = current_score_if_u_chosen;
    }

    long long maximumScoreAfterOperations(int n, std::vector<std::vector<int>>& edges, std::vector<int>& values) {
        adj.resize(n);
        dp.assign(n, std::vector<long long>(2));
        values_ptr = &values; // Store pointer to values for easy access in DFS

        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        // Start DFS from node 0, with parent -1 (indicating no parent)
        // The logic for leaf nodes correctly handles the n=1 case as well.
        dfs(0, -1); 

        // The maximum score is either by not choosing the root (dp[0][0]) or choosing it (dp[0][1]).
        return std::max(dp[0][0], dp[0][1]);
    }
};