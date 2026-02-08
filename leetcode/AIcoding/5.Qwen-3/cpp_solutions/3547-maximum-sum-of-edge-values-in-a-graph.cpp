#include <iostream>
#include <vector>
#include <algorithm>
#include <queue>

using namespace std;

class Solution {
public:
    int maxEdgeSum(vector<int>& edge, vector<vector<int>>& edges) {
        int n = edge.size();
        vector<vector<int>> graph(n);
        for (int i = 0; i < edges.size(); ++i) {
            int u = edges[i][0];
            int v = edges[i][1];
            graph[u].push_back(v);
            graph[v].push_back(u);
        }

        vector<int> dp(n, 0);
        vector<bool> visited(n, false);

        auto dfs = [&](auto&& self, int node, int parent) -> int {
            visited[node] = true;
            int max1 = 0, max2 = 0;
            for (int neighbor : graph[node]) {
                if (neighbor != parent) {
                    int val = self(self, neighbor, node);
                    if (val > max1) {
                        max2 = max1;
                        max1 = val;
                    } else if (val > max2) {
                        max2 = val;
                    }
                }
            }
            dp[node] = max1 + max2 + edge[node];
            return dp[node];
        };

        dfs(dfs, 0, -1);

        int result = 0;
        for (int i = 0; i < n; ++i) {
            result = max(result, dp[i]);
        }

        return result;
    }
};