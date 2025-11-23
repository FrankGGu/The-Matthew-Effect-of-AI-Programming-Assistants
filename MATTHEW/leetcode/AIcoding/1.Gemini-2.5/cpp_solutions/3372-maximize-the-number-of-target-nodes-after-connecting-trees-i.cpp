#include <vector>
#include <numeric>
#include <algorithm>
#include <functional>

class Solution {
public:
    int maximizeTheNumberOfTargetNodes(int n, std::vector<std::vector<int>>& edges, std::vector<int>& target) {
        if (n == 0) {
            return 0;
        }

        std::vector<std::vector<int>> adj(n);
        for (const auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        std::vector<bool> visited(n, false);
        std::vector<long long> component_sums;

        std::function<long long(int)> dfs = 
            [&](int u) {
            visited[u] = true;
            long long current_sum = target[u];
            for (int v : adj[u]) {
                if (!visited[v]) {
                    current_sum += dfs(v);
                }
            }
            return current_sum;
        };

        for (int i = 0; i < n; ++i) {
            if (!visited[i]) {
                component_sums.push_back(dfs(i));
            }
        }

        std::sort(component_sums.rbegin(), component_sums.rend());

        if (component_sums.empty()) {
            return 0;
        } else if (component_sums.size() == 1) {
            return static_cast<int>(component_sums[0]);
        } else {
            return static_cast<int>(component_sums[0] + component_sums[1]);
        }
    }
};