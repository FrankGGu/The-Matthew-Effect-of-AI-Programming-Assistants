#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int maximumPoints(vector<int>& coins, vector<vector<int>>& edges, int k) {
        int n = coins.size();
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<vector<int>> dp(n, vector<int>(201, -1));

        function<int(int, int, int, int)> solve = 
            [&](int node, int parent, int halve_count, int k) {
            if (dp[node][halve_count] != -1) {
                return dp[node][halve_count];
            }

            int take = coins[node] / (1 << min(halve_count, 20)) - k;
            int not_take = coins[node] / (1 << min(halve_count, 20));

            for (int neighbor : adj[node]) {
                if (neighbor != parent) {
                    take += solve(neighbor, node, halve_count + 1, k);
                    not_take += solve(neighbor, node, halve_count, k);
                }
            }

            return dp[node][halve_count] = max(take, not_take);
        };

        return solve(0, -1, 0, k);
    }
};