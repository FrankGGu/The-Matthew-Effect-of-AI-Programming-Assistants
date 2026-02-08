#include <vector>
#include <algorithm>
#include <unordered_map>
#include <queue>
#include <functional>

using namespace std;

class Solution {
public:
    int maxWeightedPath(int n, vector<vector<int>>& edges, int k) {
        unordered_map<int, vector<pair<int, int>>> graph;
        for (const auto& edge : edges) {
            graph[edge[0]].emplace_back(edge[1], edge[2]);
            graph[edge[1]].emplace_back(edge[0], edge[2]);
        }

        vector<vector<int>> dp(n, vector<int>(k + 1, 0));
        dp[0][0] = 0;

        for (int steps = 1; steps <= k; ++steps) {
            for (int u = 0; u < n; ++u) {
                for (const auto& [v, weight] : graph[u]) {
                    dp[v][steps] = max(dp[v][steps], dp[u][steps - 1] + weight);
                }
            }
        }

        int maxWeight = 0;
        for (int i = 0; i < n; ++i) {
            maxWeight = max(maxWeight, dp[i][k]);
        }

        return maxWeight;
    }
};