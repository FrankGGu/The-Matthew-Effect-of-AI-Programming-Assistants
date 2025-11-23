#include <vector>
#include <algorithm>
#include <numeric>

class Solution {
public:
    int maxStarSum(std::vector<int>& vals, std::vector<std::vector<int>>& edges, int k) {
        int n = vals.size();
        std::vector<std::vector<int>> adj(n);

        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj[u].push_back(v);
            adj[v].push_back(u);
        }

        int max_star_sum = *std::max_element(vals.begin(), vals.end());

        for (int i = 0; i < n; ++i) {
            int current_sum = vals[i];

            std::vector<int> neighbor_values;
            for (int neighbor_idx : adj[i]) {
                neighbor_values.push_back(vals[neighbor_idx]);
            }

            std::sort(neighbor_values.rbegin(), neighbor_values.rend());

            for (int j = 0; j < std::min((int)neighbor_values.size(), k); ++j) {
                if (neighbor_values[j] > 0) {
                    current_sum += neighbor_values[j];
                } else {
                    break;
                }
            }

            max_star_sum = std::max(max_star_sum, current_sum);
        }

        return max_star_sum;
    }
};