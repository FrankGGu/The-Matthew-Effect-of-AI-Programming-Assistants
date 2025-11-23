#include <vector>
#include <queue>
#include <unordered_map>
#include <unordered_set>

class Solution {
public:
    int numBusesToDestination(std::vector<std::vector<int>>& routes, int source, int target) {
        if (source == target) {
            return 0;
        }

        std::unordered_map<int, std::vector<int>> stop_to_routes;
        for (int i = 0; i < routes.size(); ++i) {
            for (int stop : routes[i]) {
                stop_to_routes[stop].push_back(i);
            }
        }

        if (stop_to_routes.find(source) == stop_to_routes.end() || stop_to_routes.find(target) == stop_to_routes.end()) {
            return -1;
        }

        std::queue<int> q;
        std::unordered_set<int> visited_routes;

        for (int route_idx : stop_to_routes[source]) {
            q.push(route_idx);
            visited_routes.insert(route_idx);
        }

        int bus_count = 0;

        while (!q.empty()) {
            bus_count++;
            int level_size = q.size();

            for (int i = 0; i < level_size; ++i) {
                int current_route_idx = q.front();
                q.pop();

                for (int stop : routes[current_route_idx]) {
                    if (stop == target) {
                        return bus_count;
                    }

                    for (int next_route_idx : stop_to_routes[stop]) {
                        if (visited_routes.find(next_route_idx) == visited_routes.end()) {
                            q.push(next_route_idx);
                            visited_routes.insert(next_route_idx);
                        }
                    }
                }
            }
        }

        return -1;
    }
};