#include <vector>
#include <algorithm>
#include <map> // Not strictly needed, but common for graph problems

using namespace std;

class Solution {
public:
    int max_quality;
    vector<int> node_values;
    vector<vector<pair<int, int>>> adj; // Adjacency list: {neighbor_node, travel_time}
    int max_time_limit;

    void dfs(int u, int current_time, int current_quality, vector<int>& visited_counts) {
        // If the current node is 0, this is a valid path ending at node 0.
        // Update the maximum quality found so far.
        if (u == 0) {
            max_quality = max(max_quality, current_quality);
        }

        // Explore neighbors
        for (auto& edge : adj[u]) {
            int v = edge.first;
            int travel_time = edge.second;

            int next_time = current_time + travel_time;

            // Pruning: If the path exceeds max_time_limit, stop exploring this path.
            if (next_time <= max_time_limit) {
                int next_quality = current_quality;

                // If this is the first time visiting node v in the current path,
                // add its value to the quality.
                bool is_new_visit = (visited_counts[v] == 0);
                if (is_new_visit) {
                    next_quality += node_values[v];
                }

                // Mark v as visited for the current path
                visited_counts[v]++;

                // Recurse
                dfs(v, next_time, next_quality, visited_counts);

                // Backtrack: Unmark v to explore other paths
                visited_counts[v]--;
            }
        }
    }

    int maxPathQuality(vector<int>& values, vector<vector<int>>& edges, int max_time) {
        int n = values.size();
        node_values = values;
        max_time_limit = max_time;

        adj.resize(n);
        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int t = edge[2];
            // Graph is undirected, add edges in both directions
            adj[u].push_back({v, t});
            adj[v].push_back({u, t});
        }

        // Initialize max_quality. At minimum, the path 0 -> 0 (staying at 0) has quality values[0].
        max_quality = 0; 

        // visited_counts tracks how many times each node has been visited in the current path.
        // Used to ensure node values are added only once to quality.
        vector<int> visited_counts(n, 0);

        // Start DFS from node 0.
        // Node 0 is initially visited, and its value is added to the quality.
        visited_counts[0] = 1;
        max_quality = values[0]; // The path must start and end at 0, so values[0] is always included.
        dfs(0, 0, values[0], visited_counts);

        return max_quality;
    }
};