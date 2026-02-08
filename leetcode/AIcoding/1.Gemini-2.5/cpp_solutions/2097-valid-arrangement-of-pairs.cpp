#include <vector>
#include <map>
#include <algorithm>

class Solution {
public:
    std::map<int, std::vector<int>> adj;
    std::vector<int> path_nodes;

    void dfs(int u) {
        while (!adj[u].empty()) {
            int v = adj[u].back();
            adj[u].pop_back();
            dfs(v);
        }
        path_nodes.push_back(u);
    }

    std::vector<std::vector<int>> validArrangement(std::vector<std::vector<int>>& pairs) {
        std::map<int, int> degree_diff;

        for (const auto& pair : pairs) {
            int u = pair[0];
            int v = pair[1];
            adj[u].push_back(v);
            degree_diff[u]++;
            degree_diff[v]--;
        }

        int start_node = pairs[0][0];

        for (auto const& [node, diff] : degree_diff) {
            if (diff == 1) {
                start_node = node;
                break;
            }
        }

        dfs(start_node);

        std::reverse(path_nodes.begin(), path_nodes.end());

        std::vector<std::vector<int>> result;
        for (size_t i = 0; i < path_nodes.size() - 1; ++i) {
            result.push_back({path_nodes[i], path_nodes[i+1]});
        }

        return result;
    }
};