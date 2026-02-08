#include <vector>
#include <queue>

class Solution {
public:
    bool isBipartite(std::vector<std::vector<int>>& graph) {
        int n = graph.size();
        std::vector<int> colors(n, 0); // 0: uncolored, 1: color A, 2: color B

        for (int i = 0; i < n; ++i) {
            if (colors[i] == 0) { // If node i is uncolored, start BFS from it
                std::queue<int> q;
                q.push(i);
                colors[i] = 1; // Assign color A to the starting node

                while (!q.empty()) {
                    int u = q.front();
                    q.pop();

                    for (int v : graph[u]) {
                        if (colors[v] == 0) { // If neighbor v is uncolored
                            colors[v] = (colors[u] == 1) ? 2 : 1; // Assign opposite color
                            q.push(v);
                        } else if (colors[v] == colors[u]) { // If neighbor v has the same color
                            return false; // Not bipartite
                        }
                    }
                }
            }
        }
        return true; // All nodes processed without conflicts, it's bipartite
    }
};