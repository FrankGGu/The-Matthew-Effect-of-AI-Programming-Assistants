#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    long long maxKaleidoscopeSum(vector<int>& weights, vector<vector<int>>& edges) {
        int n = weights.size();
        vector<vector<pair<int, int>>> graph(n);
        for (const auto& edge : edges) {
            int u = edge[0], v = edge[1];
            graph[u].push_back({v, 1});
            graph[v].push_back({u, 1});
        }

        vector<long long> dp(n, 0);
        vector<bool> visited(n, false);

        function<long long(int, int)> dfs = [&](int node, int parent) -> long long {
            visited[node] = true;
            long long sum = weights[node];
            for (auto [neighbor, _] : graph[node]) {
                if (neighbor != parent) {
                    sum += dfs(neighbor, node);
                }
            }
            return sum;
        };

        long long total = dfs(0, -1);
        long long maxSum = 0;

        function<void(int, int, long long)> dfs2 = [&](int node, int parent, long long parentSum) {
            long long currentSum = parentSum + weights[node];
            for (auto [neighbor, _] : graph[node]) {
                if (neighbor != parent) {
                    long long childSum = dp[neighbor];
                    currentSum = max(currentSum, parentSum + weights[node] + childSum);
                }
            }
            maxSum = max(maxSum, currentSum);

            for (auto [neighbor, _] : graph[node]) {
                if (neighbor != parent) {
                    long long newParentSum = parentSum + weights[node] + dp[neighbor];
                    dfs2(neighbor, node, newParentSum);
                }
            }
        };

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                dfs(i, -1);
            }
        }

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                dfs2(i, -1, 0);
            }
        }

        return maxSum;
    }
};