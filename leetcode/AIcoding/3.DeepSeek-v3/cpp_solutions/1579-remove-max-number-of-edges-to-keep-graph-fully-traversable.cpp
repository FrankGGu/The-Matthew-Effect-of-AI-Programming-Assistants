class UnionFind {
public:
    vector<int> parent;
    vector<int> rank;
    int count;

    UnionFind(int n) {
        parent.resize(n + 1);
        rank.resize(n + 1, 1);
        count = n;
        for (int i = 1; i <= n; ++i) {
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
        if (rootX == rootY) {
            return false;
        }
        if (rank[rootX] < rank[rootY]) {
            swap(rootX, rootY);
        }
        parent[rootY] = rootX;
        rank[rootX] += rank[rootY];
        count--;
        return true;
    }
};

class Solution {
public:
    int maxNumEdgesToRemove(int n, vector<vector<int>>& edges) {
        UnionFind ufAlice(n), ufBob(n);
        int res = 0;

        for (auto& edge : edges) {
            if (edge[0] == 3) {
                bool alice = ufAlice.unite(edge[1], edge[2]);
                bool bob = ufBob.unite(edge[1], edge[2]);
                if (!alice && !bob) {
                    res++;
                }
            }
        }

        for (auto& edge : edges) {
            if (edge[0] == 1) {
                if (!ufAlice.unite(edge[1], edge[2])) {
                    res++;
                }
            } else if (edge[0] == 2) {
                if (!ufBob.unite(edge[1], edge[2])) {
                    res++;
                }
            }
        }

        if (ufAlice.count != 1 || ufBob.count != 1) {
            return -1;
        }

        return res;
    }
};