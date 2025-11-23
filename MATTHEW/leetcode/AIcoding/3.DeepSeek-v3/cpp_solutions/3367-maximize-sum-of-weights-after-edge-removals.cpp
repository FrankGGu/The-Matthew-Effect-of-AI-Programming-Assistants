#include <vector>
#include <algorithm>
#include <numeric>

using namespace std;

class UnionFind {
private:
    vector<int> parent;
    vector<int> size;
public:
    UnionFind(int n) {
        parent.resize(n);
        size.resize(n, 1);
        iota(parent.begin(), parent.end(), 0);
    }

    int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    bool unite(int x, int y) {
        int fx = find(x);
        int fy = find(y);
        if (fx == fy) {
            return false;
        }
        if (size[fx] < size[fy]) {
            swap(fx, fy);
        }
        parent[fy] = fx;
        size[fx] += size[fy];
        return true;
    }

    int getSize(int x) {
        return size[find(x)];
    }
};

class Solution {
public:
    long long maximumWeight(int n, vector<vector<int>>& edges, int C) {
        sort(edges.begin(), edges.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[2] > b[2];
        });

        UnionFind uf(n);
        long long res = 0;

        for (const auto& edge : edges) {
            int u = edge[0] - 1;
            int v = edge[1] - 1;
            int w = edge[2];

            int sizeU = uf.getSize(u);
            int sizeV = uf.getSize(v);

            res += (long long)sizeU * sizeV * w;
            uf.unite(u, v);
        }

        return res;
    }
};