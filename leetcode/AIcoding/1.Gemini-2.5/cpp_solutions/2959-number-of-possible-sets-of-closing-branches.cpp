#include <vector>
#include <algorithm>

class Solution {
public:
    int numberOfPossibleSets(int n, std::vector<std::vector<int>>& roads, int maxTime) {
        long long INF = 1e18; 

        int count = 0;

        for (int i = 0; i < (1 << n); ++i) { 
            std::vector<std::vector<long long>> dist(n, std::vector<long long>(n, INF));

            for (int u = 0; u < n; ++u) {
                if ((i >> u) & 1) { 
                    dist[u][u] = 0;
                }
            }

            for (const auto& road : roads) {
                int u = road[0];
                int v = road[1];
                int t = road[2];

                if (((i >> u) & 1) && ((i >> v) & 1)) { 
                    dist[u][v] = std::min(dist[u][v], (long long)t);
                    dist[v][u] = std::min(dist[v][u], (long long)t); 
                }
            }

            for (int k = 0; k < n; ++k) {
                if (!((i >> k) & 1)) continue; 

                for (int u = 0; u < n; ++u) {
                    if (!((i >> u) & 1)) continue; 

                    for (int v = 0; v < n; ++v) {
                        if (!((i >> v) & 1)) continue; 

                        if (dist[u][k] != INF && dist[k][v] != INF) {
                            dist[u][v] = std::min(dist[u][v], dist[u][k] + dist[k][v]);
                        }
                    }
                }
            }

            bool current_set_valid = true;
            for (int u = 0; u < n; ++u) {
                if (!((i >> u) & 1)) continue; 

                for (int v = 0; v < n; ++v) {
                    if (!((i >> v) & 1)) continue; 

                    if (dist[u][v] > maxTime) {
                        current_set_valid = false;
                        break;
                    }
                }
                if (!current_set_valid) break;
            }

            if (current_set_valid) {
                count++;
            }
        }

        return count;
    }
};