#include <vector>
#include <queue>
#include <algorithm>

class Solution {
public:
    std::vector<std::vector<int>> getAncestors(int n, std::vector<std::vector<int>>& edges) {
        std::vector<std::vector<int>> adj_rev(n);
        for (const auto& edge : edges) {
            adj_rev[edge[1]].push_back(edge[0]);
        }

        std::vector<std::vector<int>> ancestors(n);

        for (int i = 0; i < n; ++i) {
            std::vector<bool> visited(n, false);
            std::queue<int> q;

            q.push(i);
            visited[i] = true;

            while (!q.empty()) {
                int u = q.front();
                q.pop();

                for (int v : adj_rev[u]) {
                    if (!visited[v]) {
                        visited[v] = true;
                        ancestors[i].push_back(v);
                        q.push(v);
                    }
                }
            }
            std::sort(ancestors[i].begin(), ancestors[i].end());
        }

        return ancestors;
    }
};