#include <iostream>
#include <vector>

using namespace std;

class Solution {
private:
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

public:
    int removeMaxEdgesToKeepGraphFullyTraversable(int n, vector<vector<int>>& edges) {
        parent.resize(n + 1);
        for (int i = 0; i <= n; ++i) {
            parent[i] = i;
        }

        int count = 0;

                for (const auto& edge : edges) {
            if (edge[0] == 2) {
                if (!unionSet(edge[1], edge[2])) {
                    count++;
                }
            }
        }

                vector<int> parentAlice = parent;

                for (const auto& edge : edges) {
            if (edge[0] == 1) {
                if (!unionSet(edge[1], edge[2])) {
                    count++;
                }
            }
        }

                parent.assign(n + 1, 0);
        for (int i = 0; i <= n; ++i) {
            parent[i] = i;
        }

                for (const auto& edge : edges) {
            if (edge[0] == 2) {
                if (!unionSet(edge[1], edge[2])) {
                    count++;
                }
            }
        }

                int rootAlice = find(1);
        for (int i = 2; i <= n; ++i) {
            if (find(i) != rootAlice) {
                return -1;
            }
        }

        int rootBob = find(1);
        for (int i = 2; i <= n; ++i) {
            if (find(i) != rootBob) {
                return -1;
            }
        }

        return count;
    }
};