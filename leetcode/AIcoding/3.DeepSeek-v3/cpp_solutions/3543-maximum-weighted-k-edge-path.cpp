#include <vector>
#include <algorithm>
using namespace std;

class Solution {
public:
    int maxWeight(vector<vector<int>>& edges, int n, int k) {
        vector<vector<pair<int, int>>> graph(n + 1);
        for (auto& e : edges) {
            graph[e[0]].emplace_back(e[1], e[2]);
            graph[e[1]].emplace_back(e[0], e[2]);
        }

        vector<vector<int>> dp(n + 1, vector<int>(k + 1, -1));
        for (int i = 1; i <= n; ++i) {
            dp[i][0] = 0;
        }

        int result = -1;
        for (int i = 1; i <= n; ++i) {
            result = max(result, dfs(i, k, graph, dp));
        }
        return result;
    }

private:
    int dfs(int u, int steps, vector<vector<pair<int, int>>>& graph, vector<vector<int>>& dp) {
        if (dp[u][steps] != -1) {
            return dp[u][steps];
        }
        int max_val = -1;
        for (auto& [v, w] : graph[u]) {
            int next = dfs(v, steps - 1, graph, dp);
            if (next != -1) {
                max_val = max(max_val, next + w);
            }
        }
        dp[u][steps] = max_val;
        return max_val;
    }
};