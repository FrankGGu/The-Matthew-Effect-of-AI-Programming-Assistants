#include <vector>

using namespace std;

class Solution {
public:
    vector<int> findRedundantConnection(vector<vector<int>>& edges) {
        int n = edges.size();
        vector<int> parent(n + 1);
        for (int i = 1; i <= n; ++i) {
            parent[i] = i;
        }

        auto find = [&](auto self, int x) -> int {
            if (parent[x] != x) {
                parent[x] = self(self, parent[x]);
            }
            return parent[x];
        };

        auto unite = [&](int x, int y) -> bool {
            int rootX = find(find, x);
            int rootY = find(find, y);
            if (rootX == rootY) {
                return false;
            }
            parent[rootX] = rootY;
            return true;
        };

        vector<int> redundantEdge;
        for (auto& edge : edges) {
            if (!unite(edge[0], edge[1])) {
                redundantEdge = edge;
                break;
            }
        }

        return redundantEdge;
    }
};