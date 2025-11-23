class UnionFind {
public:
    vector<int> parent;
    vector<int> rank;

    UnionFind(int size) {
        parent.resize(size + 1);
        rank.resize(size + 1, 0);
        for (int i = 0; i <= size; ++i) {
            parent[i] = i;
        }
    }

    int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    void unionSet(int x, int y) {
        int xRoot = find(x);
        int yRoot = find(y);
        if (xRoot == yRoot) return;
        if (rank[xRoot] < rank[yRoot]) {
            parent[xRoot] = yRoot;
        } else if (rank[xRoot] > rank[yRoot]) {
            parent[yRoot] = xRoot;
        } else {
            parent[yRoot] = xRoot;
            rank[xRoot]++;
        }
    }
};

class Solution {
public:
    vector<bool> areConnected(int n, int threshold, vector<vector<int>>& queries) {
        UnionFind uf(n);
        for (int i = threshold + 1; i <= n; ++i) {
            for (int j = 2 * i; j <= n; j += i) {
                uf.unionSet(i, j);
            }
        }

        vector<bool> result;
        for (const auto& query : queries) {
            int u = query[0];
            int v = query[1];
            result.push_back(uf.find(u) == uf.find(v));
        }
        return result;
    }
};