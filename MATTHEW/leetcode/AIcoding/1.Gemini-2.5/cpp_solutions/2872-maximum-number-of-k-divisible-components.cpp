#include <vector>
#include <numeric>

class Solution {
public:
    int maxKDivisibleComponents(int n, std::vector<std::vector<int>>& edges, std::vector<int>& values, int k) {
        std::vector<std::vector<int>> adj(n);
        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        int count = 0;
        dfs(0, -1, adj, values, k, count);
        return count;
    }

private:
    long long dfs(int u, int p, const std::vector<std::vector<int>>& adj, const std::vector<int>& values, int k, int& count) {
        long long current_sum = values[u];

        for (int v : adj[u]) {
            if (v == p) {
                continue;
            }
            current_sum += dfs(v, u, adj, values, k, count);
        }

        if (current_sum % k == 0) {
            count++;
            return 0;
        } else {
            return current_sum;
        }
    }
};