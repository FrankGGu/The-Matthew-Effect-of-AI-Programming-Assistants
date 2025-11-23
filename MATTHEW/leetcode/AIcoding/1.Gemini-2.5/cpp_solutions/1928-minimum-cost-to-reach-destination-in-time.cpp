#include <vector>
#include <queue>
#include <tuple>
#include <climits>
#include <algorithm>

class Solution {
public:
    int minCost(int n, std::vector<std::vector<int>>& fees, int maxTime) {
        std::vector<std::vector<std::pair<int, int>>> adj(n);
        for (const auto& fee_info : fees) {
            int u = fee_info[0];
            int v = fee_info[1];
            int time = fee_info[2];
            int cost = fee_info[3];
            adj[u].push_back({v, time});
            adj[v].push_back({u, time});
        }

        // dist[node][time] stores the minimum cost to reach 'node' at 'time'
        std::vector<std::vector<int>> dist(n, std::vector<int>(maxTime + 1, INT_MAX));

        // cost_to_node[node] stores the minimum cost to reach 'node'
        // This is needed because fees are associated with edges, not nodes
        // and we need to compare total costs to a node regardless of time for the priority queue
        std::vector<int> min_cost_to_node(n, INT_MAX);

        // Priority queue stores tuples: {cost, time, node}
        // It's a min-priority queue, ordered by cost, then time.
        std::priority_queue<std::tuple<int, int, int>,
                            std::vector<std::tuple<int, int, int>>,
                            std::greater<std::tuple<int, int, int>>> pq;

        dist[0][0] = 0;
        min_cost_to_node[0] = 0;
        pq.push({0, 0, 0}); // {cost, time, node}

        while (!pq.empty()) {
            auto [current_cost, current_time, u] = pq.top();
            pq.pop();

            // If we found a cheaper path to this node at this time, skip
            if (current_cost > dist[u][current_time]) {
                continue;
            }
            // Optimization: if we found a path to this node with higher cost than an already known path
            // to this node (regardless of time), we can potentially prune.
            // However, this is tricky because a higher cost path might allow reaching destination within maxTime
            // while a lower cost path might exceed maxTime.
            // The dist[u][current_time] check is sufficient for correctness.
            // min_cost_to_node is primarily for the final result aggregation.

            for (const auto& edge : fees) {
                int from_node = edge[0];
                int to_node = edge[1];
                int travel_time = edge[2];
                int travel_cost = edge[3];

                // Check if the current node 'u' is one end of the edge
                if (u == from_node) {
                    int v = to_node;
                    int new_time = current_time + travel_time;
                    int new_cost = current_cost + travel_cost;

                    if (new_time <= maxTime && new_cost < dist[v][new_time]) {
                        dist[v][new_time] = new_cost;
                        min_cost_to_node[v] = std::min(min_cost_to_node[v], new_cost); // Update global min cost to node v
                        pq.push({new_cost, new_time, v});
                    }
                } else if (u == to_node) { // Undirected graph
                    int v = from_node;
                    int new_time = current_time + travel_time;
                    int new_cost = current_cost + travel_cost;

                    if (new_time <= maxTime && new_cost < dist[v][new_time]) {
                        dist[v][new_time] = new_cost;
                        min_cost_to_node[v] = std::min(min_cost_to_node[v], new_cost); // Update global min cost to node v
                        pq.push({new_cost, new_time, v});
                    }
                }
            }
        }

        int min_final_cost = INT_MAX;
        for (int t = 0; t <= maxTime; ++t) {
            min_final_cost = std::min(min_final_cost, dist[n - 1][t]);
        }

        return (min_final_cost == INT_MAX) ? -1 : min_final_cost;
    }
};