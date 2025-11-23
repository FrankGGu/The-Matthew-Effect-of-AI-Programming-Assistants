#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    vector<long long> shortestDistance(int n, vector<vector<int>>& edges, vector<vector<int>>& queries) {
        vector<vector<long long>> dist(n, vector<long long>(n, LLONG_MAX));
        for (int i = 0; i < n; ++i) {
            dist[i][i] = 0;
        }
        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int w = edge[2];
            dist[u][v] = w;
            dist[v][u] = w;
        }

        for (int k = 0; k < n; ++k) {
            for (int i = 0; i < n; ++i) {
                for (int j = 0; j < n; ++j) {
                    if (dist[i][k] != LLONG_MAX && dist[k][j] != LLONG_MAX) {
                        dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j]);
                    }
                }
            }
        }

        vector<long long> ans;
        for (const auto& query : queries) {
            int u = query[0];
            int v = query[1];
            int w = query[2];
            int x = query[3];
            int y = query[4];

            vector<vector<long long>> newDist = dist;
            newDist[u][v] = min(newDist[u][v], (long long)w);
            newDist[v][u] = min(newDist[v][u], (long long)w);

            for (int k = 0; k < n; ++k) {
                for (int i = 0; i < n; ++i) {
                    for (int j = 0; j < n; ++j) {
                        if (newDist[i][k] != LLONG_MAX && newDist[k][j] != LLONG_MAX) {
                            newDist[i][j] = min(newDist[i][j], newDist[i][k] + newDist[k][j]);
                        }
                    }
                }
            }

            if (newDist[x][y] == LLONG_MAX) {
                ans.push_back(-1);
            } else {
                ans.push_back(newDist[x][y]);
            }
        }

        return ans;
    }
};