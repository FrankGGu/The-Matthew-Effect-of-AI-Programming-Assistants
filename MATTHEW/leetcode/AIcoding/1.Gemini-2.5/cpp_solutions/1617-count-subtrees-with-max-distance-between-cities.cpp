#include <vector>
#include <queue>
#include <algorithm>
#include <utility>

class Solution {
public:
    std::pair<int, int> bfs_farthest(int start_node, int mask, int n, const std::vector<std::vector<int>>& adj) {
        std::queue<std::pair<int, int>> q; // {node, distance}
        std::vector<int> dist(n, -1);

        q.push({start_node, 0});
        dist[start_node] = 0;

        int farthest_node = start_node;
        int max_d = 0;

        while (!q.empty()) {
            std::pair<int, int> curr = q.front();
            q.pop();
            int u = curr.first;
            int d = curr.second;

            if (d > max_d) {
                max_d = d;
                farthest_node = u;
            }

            for (int v : adj[u]) {
                if (((mask >> v) & 1) && dist[v] == -1) { // If v is in the current subtree (mask) and not visited
                    dist[v] = d + 1;
                    q.push({v, d + 1});
                }
            }
        }
        return {farthest_node, max_d};
    }

    std::vector<int> countSubgraphsForEachDiameter(int n, std::vector<std::vector<int>>& edges) {
        std::vector<std::vector<int>> adj(n);
        for (const auto& edge : edges) {
            adj[edge[0] - 1].push_back(edge[1] - 1);
            adj[edge[1] - 1].push_back(edge[0] - 1);
        }

        std::vector<int> ans(n - 1, 0); // Distances are from 1 to n-1, so 0-indexed array of size n-1

        for (int mask = 1; mask < (1 << n); ++mask) {
            int num_cities_in_mask = 0;
            int first_city_in_mask = -1;

            for (int i = 0; i < n; ++i) {
                if ((mask >> i) & 1) {
                    num_cities_in_mask++;
                    if (first_city_in_mask == -1) {
                        first_city_in_mask = i;
                    }
                }
            }

            if (num_cities_in_mask <= 1) {
                continue; 
            }

            std::queue<int> q_conn;
            std::vector<bool> visited_conn(n, false);
            int visited_count_conn = 0;

            q_conn.push(first_city_in_mask);
            visited_conn[first_city_in_mask] = true;
            visited_count_conn++;

            while (!q_conn.empty()) {
                int u = q_conn.front();
                q_conn.pop();

                for (int v : adj[u]) {
                    if (((mask >> v) & 1) && !visited_conn[v]) {
                        visited_conn[v] = true;
                        visited_count_conn++;
                        q_conn.push(v);
                    }
                }
            }

            if (visited_count_conn != num_cities_in_mask) {
                continue; 
            }

            std::pair<int, int> res1 = bfs_farthest(first_city_in_mask, mask, n, adj);
            int node_farthest_from_first = res1.first;

            std::pair<int, int> res2 = bfs_farthest(node_farthest_from_first, mask, n, adj);
            int diameter = res2.second;

            if (diameter > 0) { 
                ans[diameter - 1]++;
            }
        }

        return ans;
    }
};