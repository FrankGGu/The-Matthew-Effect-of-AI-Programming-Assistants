#include <vector>

using namespace std;

class Solution {
public:
    vector<int> eventualSafeNodes(vector<vector<int>>& graph) {
        int n = graph.size();
        vector<int> color(n, 0); // 0: unvisited, 1: visiting, 2: visited

        function<bool(int)> dfs = [&](int node) {
            if (color[node] == 1) return false; // cycle detected
            if (color[node] == 2) return true; // already visited and safe

            color[node] = 1; // mark as visiting

            for (int neighbor : graph[node]) {
                if (!dfs(neighbor)) return false;
            }

            color[node] = 2; // mark as visited and safe
            return true;
        };

        vector<int> safeNodes;
        for (int i = 0; i < n; ++i) {
            if (dfs(i)) {
                safeNodes.push_back(i);
            }
        }

        return safeNodes;
    }
};