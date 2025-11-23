#include <vector>
#include <queue>
#include <unordered_map>
#include <algorithm>
#include <climits>

class Solution {
public:
    long long busRapidTransit(int target, int inc, int dec, std::vector<std::vector<int>>& routes, std::vector<int>& jump) {
        if (target == 1) {
            return 0;
        }

        int n = routes.size();
        long long total_nodes = 0;
        for (const auto& route : routes) {
            total_nodes += route.size();
        }

        std::unordered_map<int, std::vector<int>> stop_to_node_ids;
        std::vector<std::pair<int, int>> node_id_to_pos(total_nodes);
        std::vector<int> node_id_to_stop_val(total_nodes);

        int current_node_id = 0;
        for (int r = 0; r < n; ++r) {
            for (int k = 0; k < routes[r].size(); ++k) {
                int stop_val = routes[r][k];
                stop_to_node_ids[stop_val].push_back(current_node_id);
                node_id_to_pos[current_node_id] = {r, k};
                node_id_to_stop_val[current_node_id] = stop_val;
                current_node_id++;
            }
        }

        const long long INF = LLONG_MAX;
        std::vector<long long> dist(total_nodes, INF);
        using P = std::pair<long long, int>;
        std::priority_queue<P, std::vector<P>, std::greater<P>> pq;

        int start = 1;
        if (stop_to_node_ids.count(start)) {
            for (int start_node_id : stop_to_node_ids.at(start)) {
                dist[start_node_id] = 0;
                pq.push({0, start_node_id});
            }
        }

        while (!pq.empty()) {
            auto [d, u] = pq.top();
            pq.pop();

            if (d > dist[u]) {
                continue;
            }

            auto [r, k] = node_id_to_pos[u];
            int s = node_id_to_stop_val[u];

            if (k > 0) {
                int v = u - 1;
                long long new_cost = d + (long long)inc * (s - node_id_to_stop_val[v]);
                if (new_cost < dist[v]) {
                    dist[v] = new_cost;
                    pq.push({new_cost, v});
                }
            }
            if (k < routes[r].size() - 1) {
                int v = u + 1;
                long long new_cost = d + (long long)inc * (node_id_to_stop_val[v] - s);
                if (new_cost < dist[v]) {
                    dist[v] = new_cost;
                    pq.push({new_cost, v});
                }
            }

            if (r < n - 1) {
                long long new_cost = d + jump[r];
                if (stop_to_node_ids.count(s)) {
                    for (int v : stop_to_node_ids.at(s)) {
                        if (node_id_to_pos[v].first == r + 1) {
                            if (new_cost < dist[v]) {
                                dist[v] = new_cost;
                                pq.push({new_cost, v});
                            }
                        }
                    }
                }
            }
        }

        long long min_cost = INF;
        if (stop_to_node_ids.count(target)) {
            for (int target_node_id : stop_to_node_ids.at(target)) {
                min_cost = std::min(min_cost, dist[target_node_id]);
            }
        }

        if (min_cost == INF) {
            return -1;
        }

        return min_cost + dec;
    }
};