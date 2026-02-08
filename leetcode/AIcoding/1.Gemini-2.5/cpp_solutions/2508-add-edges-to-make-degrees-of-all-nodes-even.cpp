#include <vector>
#include <unordered_set>

class Solution {
public:
    bool isPossible(int n, std::vector<std::vector<int>>& edges) {
        std::vector<std::unordered_set<int>> adj(n + 1);
        for (const auto& edge : edges) {
            adj[edge[0]].insert(edge[1]);
            adj[edge[1]].insert(edge[0]);
        }

        std::vector<int> odd_nodes;
        for (int i = 1; i <= n; ++i) {
            if (adj[i].size() % 2 != 0) {
                odd_nodes.push_back(i);
            }
        }

        int k = odd_nodes.size();

        if (k == 0) {
            return true;
        }

        if (k == 2) {
            int u = odd_nodes[0];
            int v = odd_nodes[1];
            if (adj[u].find(v) == adj[u].end()) {
                return true;
            }
            for (int w = 1; w <= n; ++w) {
                if (w != u && w != v) {
                    if (adj[u].find(w) == adj[u].end() && adj[v].find(w) == adj[v].end()) {
                        return true;
                    }
                }
            }
            return false;
        }

        if (k == 4) {
            int a = odd_nodes[0];
            int b = odd_nodes[1];
            int c = odd_nodes[2];
            int d = odd_nodes[3];

            if (adj[a].find(b) == adj[a].end() && adj[c].find(d) == adj[c].end()) {
                return true;
            }
            if (adj[a].find(c) == adj[a].end() && adj[b].find(d) == adj[b].end()) {
                return true;
            }
            if (adj[a].find(d) == adj[a].end() && adj[b].find(c) == adj[b].end()) {
                return true;
            }
            return false;
        }

        return false;
    }
};