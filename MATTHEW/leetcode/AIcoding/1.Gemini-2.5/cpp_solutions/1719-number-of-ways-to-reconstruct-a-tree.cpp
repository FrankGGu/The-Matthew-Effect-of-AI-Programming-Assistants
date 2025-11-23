#include <vector>
#include <unordered_map>
#include <unordered_set>
#include <algorithm>
#include <numeric>

class Solution {
public:
    int checkWays(std::vector<std::vector<int>>& pairs) {
        std::unordered_map<int, std::unordered_set<int>> adj;
        for (const auto& p : pairs) {
            adj[p[0]].insert(p[1]);
            adj[p[1]].insert(p[0]);
        }

        int n = adj.size();
        int root = -1;
        for (auto const& [node, neighbors] : adj) {
            if (neighbors.size() == n - 1) {
                root = node;
                break;
            }
        }

        if (root == -1) {
            return 0;
        }

        std::vector<int> nodes;
        nodes.reserve(n);
        for (auto const& [node, neighbors] : adj) {
            nodes.push_back(node);
        }

        std::sort(nodes.begin(), nodes.end(), [&](int a, int b) {
            return adj[a].size() > adj[b].size();
        });

        int result = 1;
        std::unordered_map<int, int> parent;

        for (int i = 1; i < n; ++i) {
            int u = nodes[i];
            int p = -1;
            int min_parent_degree = n + 1;

            for (int neighbor : adj[u]) {
                bool is_ancestor = false;
                // This check is simplified because nodes are sorted by degree.
                // A parent must have a degree >= child's degree.
                if (adj[neighbor].size() >= adj[u].size()) {
                    if (p == -1 || adj[neighbor].size() < min_parent_degree) {
                        p = neighbor;
                        min_parent_degree = adj[neighbor].size();
                    }
                }
            }

            if (p == -1) {
                return 0;
            }

            parent[u] = p;

            for (int neighbor_of_u : adj[u]) {
                if (neighbor_of_u != p) {
                    if (adj[p].find(neighbor_of_u) == adj[p].end()) {
                        return 0;
                    }
                }
            }

            if (adj[u].size() == adj[p].size()) {
                result = 2;
            }
        }

        return result;
    }
};