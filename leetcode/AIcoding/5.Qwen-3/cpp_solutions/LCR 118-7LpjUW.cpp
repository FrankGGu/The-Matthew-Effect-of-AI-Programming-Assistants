#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    vector<int> parent;

    int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    void unionSet(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) {
            parent[rootY] = rootX;
        }
    }

    vector<int> findRedundantConnection(vector<vector<int>>& edges) {
        parent.resize(1001);
        for (int i = 0; i < 1001; ++i) {
            parent[i] = i;
        }
        for (vector<int>& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            if (find(u) == find(v)) {
                return edge;
            }
            unionSet(u, v);
        }
        return {};
    }
};