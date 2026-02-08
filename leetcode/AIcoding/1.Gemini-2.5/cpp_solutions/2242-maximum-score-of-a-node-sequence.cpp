#include <vector>
#include <algorithm>
#include <utility>

class Solution {
public:
    int maximumScore(std::vector<int>& scores, std::vector<std::vector<int>>& edges) {
        int n = scores.size();
        std::vector<std::vector<std::pair<int, int>>> adj(n);

        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj[u].push_back({scores[v], v});
            adj[v].push_back({scores[u], u});
        }

        for (int i = 0; i < n; ++i) {
            std::sort(adj[i].rbegin(), adj[i].rend());
            if (adj[i].size() > 3) {
                adj[i].resize(3);
            }
        }

        int max_score = -1;

        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            for (const auto& p_u : adj[u]) {
                int neighbor_u = p_u.second;
                for (const auto& p_v : adj[v]) {
                    int neighbor_v = p_v.second;
                    if (neighbor_u != v && neighbor_v != u && neighbor_u != neighbor_v) {
                        int current_score = scores[u] + scores[v] + p_u.first + p_v.first;
                        max_score = std::max(max_score, current_score);
                    }
                }
            }
        }

        return max_score;
    }
};