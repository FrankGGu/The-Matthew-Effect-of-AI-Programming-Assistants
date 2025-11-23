#include <vector>

using namespace std;

class Solution {
public:
    int numberOfSets(int n, int maxDistance, vector<vector<int>>& roads) {
        int m = roads.size();
        int ans = 0;
        for (int mask = 0; mask < (1 << m); ++mask) {
            vector<vector<int>> adj(n, vector<int>(n, 1e9));
            for (int i = 0; i < n; ++i) {
                adj[i][i] = 0;
            }
            vector<bool> connected(n, false);
            for (int i = 0; i < m; ++i) {
                if ((mask >> i) & 1) {
                    adj[roads[i][0]][roads[i][1]] = roads[i][2];
                    adj[roads[i][1]][roads[i][0]] = roads[i][2];
                    connected[roads[i][0]] = true;
                    connected[roads[i][1]] = true;
                }
            }

            for (int k = 0; k < n; ++k) {
                for (int i = 0; i < n; ++i) {
                    for (int j = 0; j < n; ++j) {
                        adj[i][j] = min(adj[i][j], adj[i][k] + adj[k][j]);
                    }
                }
            }

            int totalDistance = 0;
            bool possible = true;
            for (int i = 0; i < n; ++i) {
                if (connected[i]) {
                    int minDistance = 1e9;
                    for (int j = 0; j < n; ++j) {
                        if (connected[j]) {
                            minDistance = min(minDistance, adj[i][j]);
                        }
                    }
                    if (minDistance > maxDistance) {
                        possible = false;
                        break;
                    }
                    totalDistance += minDistance;
                }
            }

            if (possible) {
                ans++;
            }
        }
        return ans;
    }
};