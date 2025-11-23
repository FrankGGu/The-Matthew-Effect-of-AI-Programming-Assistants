#include <vector>
#include <numeric>
#include <algorithm>

class Solution {
public:
    // 0: unvisited, 1: visiting (in current DFS path), 2: safe, 3: unsafe
    bool dfs(int u, const std::vector<std::vector<int>>& graph, std::vector<int>& color) {
        if (color[u] != 0) {
            return color[u] == 2; // If already safe, return true. If visiting or unsafe, return false.
        }

        color[u] = 1; // Mark as visiting

        for (int v : graph[u]) {
            if (!dfs(v, graph, color)) {
                color[u] = 3; // If any neighbor leads to an unsafe path, u is unsafe
                return false;
            }
        }

        color[u] = 2; // All neighbors lead to safe paths, so u is safe
        return true;
    }

    std::vector<int> eventualSafeNodes(std::vector<std::vector<int>>& graph) {
        int n = graph.size();
        std::vector<int> color(n, 0); // Initialize all nodes as unvisited
        std::vector<int> safeNodes;

        for (int i = 0; i < n; ++i) {
            if (dfs(i, graph, color)) {
                safeNodes.push_back(i);
            }
        }

        return safeNodes;
    }
};