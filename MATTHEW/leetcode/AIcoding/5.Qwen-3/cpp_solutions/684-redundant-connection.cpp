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

    bool unionSet(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX == rootY) {
            return false;
        }
        parent[rootY] = rootX;
        return true;
    }

    vector<int> findRedundantConnection(vector<vector<int>>& edges) {
        parent.resize(1001);
        for (int i = 0; i <= 1000; ++i) {
            parent[i] = i;
        }
        for (auto& edge : edges) {
            if (!unionSet(edge[0], edge[1])) {
                return edge;
            }
        }
        return {};
    }
};