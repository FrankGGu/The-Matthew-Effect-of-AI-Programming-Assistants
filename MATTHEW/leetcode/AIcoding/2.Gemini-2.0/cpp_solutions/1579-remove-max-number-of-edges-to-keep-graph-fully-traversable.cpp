#include <vector>

using namespace std;

class UnionFind {
public:
    UnionFind(int n) : parent(n + 1), count(n) {
        for (int i = 0; i <= n; ++i) {
            parent[i] = i;
        }
    }

    int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    bool unite(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) {
            parent[rootX] = rootY;
            count--;
            return true;
        }
        return false;
    }

    int getCount() {
        return count;
    }

private:
    vector<int> parent;
    int count;
};

class Solution {
public:
    int maxNumEdgesToRemove(int n, vector<vector<int>>& edges) {
        int removedEdges = 0;
        UnionFind aliceUF(n);
        UnionFind bobUF(n);

        for (auto& edge : edges) {
            if (edge[0] == 3) {
                if (aliceUF.unite(edge[1], edge[2])) {
                    bobUF.unite(edge[1], edge[2]);
                } else {
                    removedEdges++;
                }
            }
        }

        for (auto& edge : edges) {
            if (edge[0] == 1) {
                if (!aliceUF.unite(edge[1], edge[2])) {
                    removedEdges++;
                }
            } else if (edge[0] == 2) {
                if (!bobUF.unite(edge[1], edge[2])) {
                    removedEdges++;
                }
            }
        }

        if (aliceUF.getCount() != 1 || bobUF.getCount() != 1) {
            return -1;
        }

        return removedEdges;
    }
};