#include <vector>
#include <queue>

class Solution {
public:
    bool possibleBipartition(int n, std::vector<std::vector<int>>& dislikes) {
        std::vector<std::vector<int>> adj(n + 1);
        for (const auto& edge : dislikes) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        std::vector<int> colors(n + 1, 0); 

        for (int i = 1; i <= n; ++i) {
            if (colors[i] == 0) {
                std::queue<int> q;
                q.push(i);
                colors[i] = 1;

                while (!q.empty()) {
                    int u = q.front();
                    q.pop();

                    for (int v : adj[u]) {
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