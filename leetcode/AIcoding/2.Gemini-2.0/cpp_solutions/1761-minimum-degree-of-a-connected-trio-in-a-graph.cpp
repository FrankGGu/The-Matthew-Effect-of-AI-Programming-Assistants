#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minTrioDegree(int n, vector<vector<int>>& edges) {
        vector<vector<bool>> adj(n, vector<bool>(n, false));
        vector<int> degree(n, 0);

        for (auto& edge : edges) {
            int u = edge[0] - 1;
            int v = edge[1] - 1;
            adj[u][v] = true;
            adj[v][u] = true;
            degree[u]++;
            degree[v]++;
        }

        int min_degree = INT_MAX;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                if (adj[i][j]) {
                    for (int k = j + 1; k < n; ++k) {
                        if (adj[i][k] && adj[j][k]) {
                            min_degree = min(min_degree, degree[i] + degree[j] + degree[k] - 6);
                        }
                    }
                }
            }
        }

        return (min_degree == INT_MAX) ? -1 : min_degree;
    }
};