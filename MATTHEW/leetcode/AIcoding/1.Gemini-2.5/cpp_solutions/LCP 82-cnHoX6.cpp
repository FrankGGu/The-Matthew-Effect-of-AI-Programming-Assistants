#include <vector>
#include <algorithm>
#include <utility> // For std::pair

const int N_MAX = 100005;
const int TYPE_MAX = 100005; // Max value for type[i] and query type v

std::vector<int> adj[N_MAX];
int node_val[N_MAX];
int node_type[N_MAX];
int tin[N_MAX], tout[N_MAX]; // Entry and exit times for Euler tour
int timer; // Global timer for DFS

std::vector<std::pair<int, int>> type_nodes[TYPE_MAX];
std::vector<long long> type_prefix_sums[TYPE_MAX];

void dfs(int u, int p) {
    tin[u] = ++timer; // Assign entry time
    type_nodes[node_type[u]].push_back({tin[u], node_val[u]});
    for (int v : adj[u]) {
        if (v == p) continue;
        dfs(v, u);
    }
    tout[u] = timer; // Assign exit time (max tin in its subtree)
}

class Solution {
public:
    std::vector<long long> getSum(int n, std::vector<std::vector<int>>& edges, std::vector<int>& value, std::vector<int>& type, std::vector<std::vector<int>>& queries) {
        // Reset global variables for each test case
        timer = 0;
        for (int i = 0; i < n; ++i) {
            adj[i].clear();
        }

        // Determine the maximum type value to efficiently clear type-specific data structures
        int max_type_val = 0;
        for(int t_val : type) {
            if (t_val > max_type_val) max_type_val = t_val;
        }
        // Clear only the type-specific vectors that might have been used
        for (int i = 0; i <= max_type_val; ++i) {
            type_nodes[i].clear();
            type_prefix_sums[i].clear();
        }

        // Copy input values and types to global arrays
        for (int i = 0; i < n; ++i) {
            node_val[i] = value[i];
            node_type[i] = type[i];
        }

        // Build adjacency list from edges
        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        // Perform DFS starting from node 0 (assuming it's the root of the tree)
        dfs(0, -1);

        // Precompute prefix sums for each type
        for (int t = 0; t <= max_type_val; ++t) {
            if (type_nodes[t].empty()) continue; // Skip if no nodes of this type

            // Sort nodes of the current type by their entry times (tin)
            std::sort(type_nodes[t].begin(), type_nodes[t].end());

            // Compute prefix sums for the values of nodes of this type
            type_prefix_sums[t].resize(type_nodes[t].size());
            type_prefix_sums[t][0] = type_nodes[t][0].second;
            for (int i = 1; i < type_nodes[t].size(); ++i) {
                type_prefix_sums[t][i] = type_prefix_sums[t][i-1] + type_nodes[t][i].second;
            }
        }

        std::vector<long long> results;
        results.reserve(queries.size());

        // Process each query
        for (const auto& query : queries) {
            int u_query = query[0]; // Query node
            int v_query = query[1]; // Target type

            long long current_sum = 0;

            // Check if the target type is valid and has associated nodes
            if (v_query >= 0 && v_query <= max_type_val && !type_nodes[v_query].empty()) {
                std::vector<std::pair<int, int>>& current_type_nodes = type_nodes[v_query];
                std::vector<long long>& current_prefix_sums = type_prefix_sums[v_query];

                // Find the range of nodes within the subtree of u_query that have type v_query
                // A node x is in subtree of u_query if tin[u_query] <= tin[x] <= tout[u_query].

                // lower_bound finds the first element whose tin is >= tin[u_query]
                // The -1 is a dummy value for the pair's second element to ensure comparison only on tin.
                auto it_start = std::lower_bound(current_type_nodes.begin(), current_type_nodes.end(), std::make_pair(tin[u_query], -1));

                // upper_bound finds the first element whose tin is > tout[u_query]
                // 1001 is a dummy value (max node_val is 1000) to ensure comparison only on tin.
                auto it_end = std::upper_bound(current_type_nodes.begin(), current_type_nodes.end(), std::make_pair(tout[u_query], 1001)); 

                int idx_start = it_start - current_type_nodes.begin();
                int idx_end = it_end - current_type_nodes.begin();

                // If there are nodes of type v_query within the subtree range
                if (idx_start < idx_end) {
                    current_sum = current_prefix_sums[idx_end - 1];
                    if (idx_start > 0) {
                        current_sum -= current_prefix_sums[idx_start - 1];
                    }
                }
            }
            results.push_back(current_sum);
        }

        return results;
    }
};