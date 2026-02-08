#include <iostream>
#include <vector>
#include <algorithm>
#include <climits>

using namespace std;

class Solution {
public:
    int maximumSum(int n, vector<int>& edges, vector<int>& values) {
        vector<vector<int>> graph(n);
        for (int i = 0; i < edges.size(); ++i) {
            int u = edges[i][0];
            int v = edges[i][1];
            graph[u].push_back(v);
            graph[v].push_back(u);
        }

        vector<int> dp(n, 0);
        vector<bool> visited(n, false);

        function<int(int, int)> dfs = [&](int node, int parent) -> int {
            visited[node] = true;
            int max1 = 0, max2 = 0;
            for (int neighbor : graph[node]) {
                if (neighbor != parent) {
                    int res = dfs(neighbor, node);
                    if (res > max1) {
                        max2 = max1;
                        max1 = res;
                    } else if (res > max2) {
                        max2 = res;
                    }
                }
            }
            dp[node] = max1 + max2 + values[node];
            return dp[node];
        };

        dfs(0, -1);

        return *max_element(dp.begin(), dp.end());
    }
};