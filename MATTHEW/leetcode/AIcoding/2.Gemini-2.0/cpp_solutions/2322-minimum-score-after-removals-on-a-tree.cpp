#include <vector>
#include <algorithm>

using namespace std;

class Solution {
public:
    int minimumScore(int n, vector<vector<int>>& edges, vector<int>& values) {
        vector<vector<int>> adj(n);
        for (auto& edge : edges) {
            adj[edge[0]].push_back(edge[1]);
            adj[edge[1]].push_back(edge[0]);
        }

        vector<int> parent(n, -1);
        vector<int> subtreeXor(n, 0);
        vector<int> depth(n, 0);

        function<void(int, int, int)> dfs = [&](int u, int p, int d) {
            parent[u] = p;
            depth[u] = d;
            subtreeXor[u] = values[u];
            for (int v : adj[u]) {
                if (v != p) {
                    dfs(v, u, d + 1);
                    subtreeXor[u] ^= subtreeXor[v];
                }
            }
        };

        dfs(0, -1, 0);

        int minScore = INT_MAX;
        for (int i = 1; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int a = i, b = j;
                int xorA, xorB, xorC;

                function<bool(int, int)> isAncestor = [&](int u, int v) {
                    while (v != -1) {
                        if (v == u) return true;
                        v = parent[v];
                    }
                    return false;
                };

                if (isAncestor(a, b)) {
                    xorA = subtreeXor[b];
                    xorB = subtreeXor[0] ^ xorA;
                    xorC = subtreeXor[a] ^ subtreeXor[b];
                } else if (isAncestor(b, a)) {
                    xorA = subtreeXor[a];
                    xorB = subtreeXor[0] ^ xorA;
                    xorC = subtreeXor[b] ^ subtreeXor[a];
                } else {
                    xorA = subtreeXor[a];
                    xorB = subtreeXor[b];
                    xorC = subtreeXor[0] ^ xorA ^ xorB;
                }

                int mx = max({xorA, xorB, xorC});
                int mn = min({xorA, xorB, xorC});
                minScore = min(minScore, mx - mn);
            }
        }

        return minScore;
    }
};