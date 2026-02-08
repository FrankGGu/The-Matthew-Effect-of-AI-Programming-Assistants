#include <vector>
#include <queue>

class Solution {
public:
    bool isBipartite(std::vector<std::vector<int>>& graph) {
        int n = graph.size();
        std::vector<int> colors(n, 0); // 0: uncolored, 1: color A, -1: color B

        for (int i = 0; i < n; ++i) {
            if (colors[i] == 0) {
                std::queue<int> q;
                q.push(i);
                colors[i] = 1;

                while (!q.empty()) {
                    int u = q.front();
                    q.pop();

                    for (int v : graph[u]) {
                        if (colors[v] == 0) {
                            colors[v] = -colors[u];
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