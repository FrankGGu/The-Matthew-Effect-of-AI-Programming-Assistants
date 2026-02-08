#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<int> shortestDistance(int n, vector<vector<int>>& edges, vector<vector<int>>& queries) {
        vector<vector<long long>> dist(n, vector<long long>(n, 1e12));
        for (int i = 0; i < n; ++i) {
            dist[i][i] = 0;
        }
        for (auto& edge : edges) {
            int u = edge[0], v = edge[1], w = edge[2];
            dist[u][v] = w;
            dist[v][u] = w;
        }

        for (int k = 0; k < n; ++k) {
            for (int i = 0; i < n; ++i) {
                for (int j = 0; j < n; ++j) {
                    dist[i][j] = min(dist[i][j], dist[i][k] + dist[k][j]);
                }
            }
        }

        vector<int> ans;
        for (auto& query : queries) {
            int u = query[0], v = query[1], w = query[2];
            long long min_dist = 1e12;
            for (int i = 0; i < n; ++i) {
                min_dist = min(min_dist, dist[u][i] + w + dist[v][i]);
                min_dist = min(min_dist, dist[v][i] + w + dist[u][i]);
            }

            if (min_dist >= 1e12) {
                ans.push_back(-1);
            } else {
                ans.push_back(min_dist);
            }
        }

        return ans;
    }
};