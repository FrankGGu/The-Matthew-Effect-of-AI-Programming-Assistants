#include <vector>
#include <climits>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numberOfSets(int n, int maxDistance, vector<vector<int>>& roads) {
        int res = 0;
        for (int mask = 0; mask < (1 << n); ++mask) {
            vector<vector<int>> dist(n, vector<int>(n, INT_MAX / 2));
            for (int i = 0; i < n; ++i) {
                dist[i][i] = 0;
            }
            for (auto& road : roads) {
                int u = road[0], v = road[1], w = road[2];
                if ((mask & (1 << u)) && (mask & (1 << v))) {
                    dist[u][v] = min(dist[u][v], w);
                    dist[v][u] = min(dist[v][u], w);
                }
            }
            for (int k = 0; k < n; ++k) {
                if (!(mask & (1 << k))) continue;
                for (int i = 0; i < n; ++i) {
                    if (!(mask & (1 << i))) continue;
                    for (int j = 0; j < n; ++j) {
                        if (!(mask & (1 << j))) continue;
                        dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j]);
                    }
                }
            }
            bool valid = true;
            for (int i = 0; i < n && valid; ++i) {
                if (!(mask & (1 << i))) continue;
                for (int j = 0; j < n && valid; ++j) {
                    if (!(mask & (1 << j))) continue;
                    if (dist[i][j] > maxDistance) {
                        valid = false;
                    }
                }
            }
            if (valid) {
                res++;
            }
        }
        return res;
    }
};