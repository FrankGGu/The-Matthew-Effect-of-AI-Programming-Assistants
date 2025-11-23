#include <vector>
#include <queue>
#include <numeric>

class Solution {
public:
    bool isBipartite(std::vector<std::vector<int>>& graph) {
        int n = graph.size();
        std::vector<int> colors(n, -1);

        for (int i = 0; i < n; ++i) {
            if (colors[i] == -1) {
                std::queue<int> q;
                q.push(i);
                colors[i] = 0;

                while (!q.empty()) {
                    int u = q.front();
                    q.pop();

                    for (int v : graph[u]) {
                        if (colors[v] == -1) {
                            colors[v] = 1 - colors[u];
                            q.push(v);
                        } else if (colors[v] == colors[u]) {
                            return false;
                        }
                    }
                }
            }
        }
        return true;
    }
};