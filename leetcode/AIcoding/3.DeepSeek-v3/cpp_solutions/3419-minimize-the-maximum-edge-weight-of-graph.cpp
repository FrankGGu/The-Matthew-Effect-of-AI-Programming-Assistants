class UnionFind {
private:
    vector<int> parent;
    vector<int> rank;
public:
    UnionFind(int size) {
        parent.resize(size);
        rank.resize(size, 0);
        for (int i = 0; i < size; ++i) {
            parent[i] = i;
        }
    }

    int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    bool unionSet(int x, int y) {
        int xRoot = find(x);
        int yRoot = find(y);
        if (xRoot == yRoot) {
            return false;
        }
        if (rank[xRoot] < rank[yRoot]) {
            parent[xRoot] = yRoot;
        } else if (rank[xRoot] > rank[yRoot]) {
            parent[yRoot] = xRoot;
        } else {
            parent[yRoot] = xRoot;
            rank[xRoot]++;
        }
        return true;
    }
};

class Solution {
public:
    int minMaxEdgeWeight(int n, vector<vector<int>>& edges, int threshold) {
        sort(edges.begin(), edges.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[2] < b[2];
        });

        UnionFind uf(n);
        int maxEdge = 0;
        int components = n;

        for (const auto& edge : edges) {
            int u = edge[0];
            int v = edge[1];
            int weight = edge[2];
            if (uf.unionSet(u, v)) {
                maxEdge = max(maxEdge, weight);
                components--;
                if (components == threshold) {
                    break;
                }
            }
        }

        return maxEdge;
    }
};