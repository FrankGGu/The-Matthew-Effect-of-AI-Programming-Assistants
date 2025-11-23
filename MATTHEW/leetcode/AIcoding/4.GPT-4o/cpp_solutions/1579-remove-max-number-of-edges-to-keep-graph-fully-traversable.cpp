class UnionFind {
public:
    vector<int> parent, rank;
    UnionFind(int n) {
        parent.resize(n + 1);
        rank.resize(n + 1, 0);
        for (int i = 0; i <= n; ++i)
            parent[i] = i;
    }

    int find(int x) {
        if (parent[x] != x)
            parent[x] = find(parent[x]);
        return parent[x];
    }

    bool unionSets(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX == rootY) return false;
        if (rank[rootX] < rank[rootY]) 
            parent[rootX] = rootY;
        else if (rank[rootX] > rank[rootY]) 
            parent[rootY] = rootX;
        else {
            parent[rootY] = rootX;
            rank[rootX]++;
        }
        return true;
    }
};

class Solution {
public:
    int maxNumEdgesToRemove(int n, vector<vector<int>>& edges) {
        UnionFind ufAlice(n), ufBob(n);
        int totalEdges = 0, usedEdges = 0;

        for (auto& edge : edges) {
            if (edge[0] == 3) {
                if (ufAlice.unionSets(edge[1], edge[2]) || ufBob.unionSets(edge[1], edge[2])) {
                    usedEdges++;
                }
                totalEdges++;
            }
        }

        for (auto& edge : edges) {
            if (edge[0] == 1) {
                if (ufAlice.unionSets(edge[1], edge[2])) {
                    usedEdges++;
                }
                totalEdges++;
            } else if (edge[0] == 2) {
                if (ufBob.unionSets(edge[1], edge[2])) {
                    usedEdges++;
                }
                totalEdges++;
            }
        }

        if (ufAlice.find(1) != ufAlice.find(n) || ufBob.find(1) != ufBob.find(n)) 
            return -1;

        return edges.size() - usedEdges;
    }
};