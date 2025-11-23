class UnionFind {
public:
    vector<int> parent;
    vector<int> rank;
    UnionFind(int n) {
        parent.resize(n);
        rank.resize(n, 0);
        for (int i = 0; i < n; ++i) parent[i] = i;
    }
    int find(int x) {
        if (parent[x] != x) parent[x] = find(parent[x]);
        return parent[x];
    }
    bool unionSet(int x, int y) {
        int xRoot = find(x), yRoot = find(y);
        if (xRoot == yRoot) return false;
        if (rank[xRoot] < rank[yRoot]) parent[xRoot] = yRoot;
        else if (rank[xRoot] > rank[yRoot]) parent[yRoot] = xRoot;
        else {
            parent[yRoot] = xRoot;
            rank[xRoot]++;
        }
        return true;
    }
};

class Solution {
public:
    vector<vector<int>> findCriticalAndPseudoCriticalEdges(int n, vector<vector<int>>& edges) {
        int m = edges.size();
        for (int i = 0; i < m; ++i) edges[i].push_back(i);
        sort(edges.begin(), edges.end(), [](const vector<int>& a, const vector<int>& b) {
            return a[2] < b[2];
        });

        UnionFind uf(n);
        int mstWeight = 0;
        for (auto& edge : edges) {
            if (uf.unionSet(edge[0], edge[1])) mstWeight += edge[2];
        }

        vector<int> critical, pseudo;
        for (int i = 0; i < m; ++i) {
            UnionFind ufIgnore(n);
            int ignoreWeight = 0, cnt = 0;
            for (int j = 0; j < m; ++j) {
                if (i != j && ufIgnore.unionSet(edges[j][0], edges[j][1])) {
                    ignoreWeight += edges[j][2];
                    cnt++;
                }
            }
            if (cnt != n - 1 || ignoreWeight > mstWeight) {
                critical.push_back(edges[i][3]);
                continue;
            }

            UnionFind ufForce(n);
            int forceWeight = edges[i][2];
            ufForce.unionSet(edges[i][0], edges[i][1]);
            for (int j = 0; j < m; ++j) {
                if (i != j && ufForce.unionSet(edges[j][0], edges[j][1])) {
                    forceWeight += edges[j][2];
                }
            }
            if (forceWeight == mstWeight) pseudo.push_back(edges[i][3]);
        }

        return {critical, pseudo};
    }
};