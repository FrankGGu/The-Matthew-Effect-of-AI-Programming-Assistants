#include <vector>
#include <algorithm>
#include <utility>

class Solution {
public:
    int max_diff = 0;
    std::vector<std::vector<int>> adj;
    std::vector<int> node_prices;

    std::pair<int, int> dfs(int u, int parent) {
        int current_min_price = node_prices[u];
        int current_max_price = node_prices[u];

        for (int v : adj[u]) {
            if (v == parent) {
                continue;
            }

            std::pair<int, int> child_min_max = dfs(v, u);
            int child_min_price = child_min_max.first;
            int child_max_price = child_min_max.second;

            max_diff = std::max(max_diff, std::abs(node_prices[u] - child_min_price));
            max_diff = std::max(max_diff, std::abs(node_prices[u] - child_max_price));

            current_min_price = std::min(current_min_price, child_min_price);
            current_max_price = std::max(current_max_price, child_max_price);
        }

        return {current_min_price, current_max_price};
    }

    int maxPriceSumDifference(int n, std::vector<std::vector<int>>& edges, std::vector<int>& prices) {
        node_prices = prices;
        adj.resize(n);

        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        dfs(0, -1); 

        return max_diff;
    }
};