#include <vector>
#include <queue>
#include <algorithm>

using namespace std;

class Solution {
public:
    int electricCarTour(vector<vector<int>>& paths, vector<int>& charge, int start_node) {
        int n = charge.size();
        const long long INF = -1;
        vector<vector<long long>> dist(n, vector<long long>(n, INF));

        for (int i = 0; i < n; ++i) {
            dist[i][i] = 0;
        }

        for (const auto& path : paths) {
            int u = path[0], v = path[1], w = path[2];
            if (dist[u][v] == INF || dist[u][v] > w) {
                dist[u][v] = w;
                dist[v][u] = w;
            }
        }

        for (int k = 0; k < n; ++k) {
            for (int i = 0; i < n; ++i) {
                for (int j = 0; j < n; ++j) {
                    if (dist[i][k] != INF && dist[k][j] != INF) {
                        if (dist[i][j] == INF || dist[i][j] > dist[i][k] + dist[k][j]) {
                            dist[i][j] = dist[i][k] + dist[k][j];
                        }
                    }
                }
            }
        }

        vector<vector<long long>> dp(n, vector<long long>(n, INF));

        long long max_total_time = 0;

        for (int k = 0; k < n; ++k) {
            max_total_time = max(max_total_time, (long long)charge[k]);
            for (int v = 0; v < n; ++v) {
                if (dist[k][v] != INF && dist[k][v] <= charge[k]) {
                    dp[0][v] = max(dp[0][v], (long long)charge[k]);
                }
            }
        }

        for (int k = 0; k < n - 1; ++k) {
            for (int u = 0; u < n; ++u) {
                if (dp[k][u] != INF) {
                    max_total_time = max(max_total_time, dp[k][u] + charge[u]);
                    for (int v = 0; v < n; ++v) {
                        if (dist[u][v] != INF && dist[u][v] <= charge[u]) {
                            long long new_time = dp[k][u] + charge[u];
                            if (dp[k+1][v] < new_time) {
                                dp[k+1][v] = new_time;
                            }
                        }
                    }
                }
            }
        }

        for (int u = 0; u < n; ++u) {
            if (dp[n - 1][u] != INF) {
                max_total_time = max(max_total_time, dp[n - 1][u] + charge[u]);
            }
        }

        return max_total_time;
    }
};