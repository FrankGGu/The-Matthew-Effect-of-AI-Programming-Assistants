#include <vector>
#include <queue>
#include <map>
#include <climits>
#include <cmath>
#include <algorithm>

using namespace std;

long long manhattan_distance(int x1, int y1, int x2, int y2) {
    return abs(static_cast<long long>(x1) - x2) + abs(static_cast<long long>(y1) - y2);
}

class Solution {
public:
    int minimumCost(vector<int>& start, vector<int>& target, vector<vector<int>>& specialRoads) {
        map<pair<int, int>, int> point_to_id;
        vector<pair<int, int>> id_to_point;

        auto get_id = [&](int x, int y) {
            pair<int, int> p = {x, y};
            if (point_to_id.find(p) == point_to_id.end()) {
                int new_id = id_to_point.size();
                point_to_id[p] = new_id;
                id_to_point.push_back(p);
            }
            return point_to_id[p];
        };

        int start_id = get_id(start[0], start[1]);
        int target_id = get_id(target[0], target[1]);

        for (const auto& road : specialRoads) {
            get_id(road[0], road[1]);
            get_id(road[2], road[3]);
        }

        int num_points = id_to_point.size();

        vector<vector<pair<int, long long>>> adj(num_points);

        for (int i = 0; i < num_points; ++i) {
            for (int j = i + 1; j < num_points; ++j) {
                long long cost = manhattan_distance(id_to_point[i].first, id_to_point[i].second,
                                                    id_to_point[j].first, id_to_point[j].second);
                adj[i].push_back({j, cost});
                adj[j].push_back({i, cost});
            }
        }

        for (const auto& road : specialRoads) {
            int u_id = get_id(road[0], road[1]);
            int v_id = get_id(road[2], road[3]);
            long long special_cost = road[4];
            adj[u_id].push_back({v_id, special_cost});
        }

        vector<long long> dist(num_points, LLONG_MAX);
        priority_queue<pair<long long, int>, vector<pair<long long, int>>, greater<pair<long long, int>>> pq;

        dist[start_id] = 0;
        pq.push({0, start_id});

        while (!pq.empty()) {
            long long current_cost = pq.top().first;
            int u_id = pq.top().second;
            pq.pop();

            if (current_cost > dist[u_id]) {
                continue;
            }

            for (const auto& edge : adj[u_id]) {
                int v_id = edge.first;
                long long weight = edge.second;

                if (dist[u_id] + weight < dist[v_id]) {
                    dist[v_id] = dist[u_id] + weight;
                    pq.push({dist[v_id], v_id});
                }
            }
        }

        return dist[target_id];
    }
};