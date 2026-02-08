class Solution {
public:
    int findCheapestPrice(int n, vector<vector<int>>& flights, int src, int dst, int k) {
        vector<vector<pair<int, int>>> adj(n);
        for (auto& flight : flights) {
            adj[flight[0]].emplace_back(flight[1], flight[2]);
        }

        vector<int> dist(n, INT_MAX);
        dist[src] = 0;

        queue<pair<int, int>> q;
        q.push({src, 0});
        int stops = 0;

        while (!q.empty() && stops <= k) {
            int sz = q.size();
            while (sz--) {
                auto [node, distance] = q.front();
                q.pop();

                for (auto& [neighbor, price] : adj[node]) {
                    if (distance + price < dist[neighbor]) {
                        dist[neighbor] = distance + price;
                        q.push({neighbor, dist[neighbor]});
                    }
                }
            }
            stops++;
        }

        return dist[dst] == INT_MAX ? -1 : dist[dst];
    }
};