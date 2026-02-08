#include <vector>
#include <algorithm>

class Solution {
public:
    int findCheapestPrice(int n, std::vector<std::vector<int>>& flights, int src, int dst, int k) {
        const int INF = 1e9;
        std::vector<int> dist(n, INF);
        dist[src] = 0;

        for (int i = 0; i <= k; ++i) {
            std::vector<int> temp_dist = dist;
            for (const auto& flight : flights) {
                int u = flight[0];
                int v = flight[1];
                int price = flight[2];
                if (dist[u] != INF) {
                    temp_dist[v] = std::min(temp_dist[v], dist[u] + price);
                }
            }
            dist = temp_dist;
        }

        return dist[dst] == INF ? -1 : dist[dst];
    }
};