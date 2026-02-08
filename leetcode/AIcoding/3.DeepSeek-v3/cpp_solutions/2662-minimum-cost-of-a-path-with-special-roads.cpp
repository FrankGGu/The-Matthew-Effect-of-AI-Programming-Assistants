class Solution {
public:
    int minimumCost(vector<int>& start, vector<int>& target, vector<vector<int>>& specialRoads) {
        using pii = pair<int, int>;
        map<pii, int> dist;
        priority_queue<pair<int, pii>, vector<pair<int, pii>>, greater<pair<int, pii>>> pq;

        pii s = {start[0], start[1]};
        pii t = {target[0], target[1]};
        dist[s] = 0;
        pq.push({0, s});

        while (!pq.empty()) {
            auto [d, u] = pq.top();
            pq.pop();
            if (u == t) return d;
            if (d > dist[u]) continue;

            int x = u.first, y = u.second;
            for (auto& road : specialRoads) {
                int a = road[0], b = road[1], c = road[2], d_road = road[3], cost = road[4];
                pii v = {c, d_road};
                int new_dist = d + abs(x - a) + abs(y - b) + cost;
                if (!dist.count(v) || new_dist < dist[v]) {
                    dist[v] = new_dist;
                    pq.push({new_dist, v});
                }
            }

            pii v = t;
            int new_dist = d + abs(x - v.first) + abs(y - v.second);
            if (!dist.count(v) || new_dist < dist[v]) {
                dist[v] = new_dist;
                pq.push({new_dist, v});
            }
        }
        return -1;
    }
};