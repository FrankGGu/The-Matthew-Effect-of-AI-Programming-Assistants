#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> adj;
    std::vector<int> subtree_sizes;
    int N;

    int dfs_calculate_subtree_sizes(int u) {
        int current_subtree_size = 1;
        for (int v : adj[u]) {
            current_subtree_size += dfs_calculate_subtree_sizes(v);
        }
        subtree_sizes[u] = current_subtree_size;
        return current_subtree_size;
    }

    int countHighestScoreNodes(std::vector<int>& parents) {
        N = parents.size();
        adj.resize(N);
        subtree_sizes.resize(N);

        for (int i = 1; i < N; ++i) {
            adj[parents[i]].push_back(i);
        }

        dfs_calculate_subtree_sizes(0);

        long long max_score = 0;
        int count_max_score = 0;

        for (int i = 0; i < N; ++i) {
            long long current_score = 1;
            long long remaining_nodes_for_parent_component = N - 1;

            for (int child : adj[i]) {
                long long child_subtree_size = subtree_sizes[child];
                current_score *= child_subtree_size;
                remaining_nodes_for_parent_component -= child_subtree_size;
            }

            if (remaining_nodes_for_parent_component > 0) {
                current_score *= remaining_nodes_for_parent_component;
            }

            if (current_score > max_score) {
                max_score = current_score;
                count_max_score = 1;
            } else if (current_score == max_score) {
                count_max_score++;
            }
        }

        return count_max_score;
    }
};