class UnionFind {
public:
    vector<int> parent;
    UnionFind(int n) {
        parent.resize(n);
        for (int i = 0; i < n; ++i) {
            parent[i] = i;
        }
    }
    int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }
    void unite(int x, int y) {
        parent[find(x)] = find(y);
    }
};

class Solution {
public:
    vector<vector<int>> matrixRankTransform(vector<vector<int>>& matrix) {
        int m = matrix.size();
        int n = matrix[0].size();
        map<int, vector<pair<int, int>>> valueToPositions;
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                valueToPositions[matrix[i][j]].emplace_back(i, j);
            }
        }

        vector<int> rank(m + n, 0);
        vector<vector<int>> result(m, vector<int>(n));

        for (auto& [val, positions] : valueToPositions) {
            UnionFind uf(m + n);
            vector<int> rank2 = rank;

            for (auto& [i, j] : positions) {
                int rootI = uf.find(i), rootJ = uf.find(j + m);
                if (rootI != rootJ) {
                    uf.unite(rootI, rootJ);
                    rank2[uf.find(rootI)] = max(rank2[rootI], rank2[rootJ]);
                }
            }

            for (auto& [i, j] : positions) {
                int root = uf.find(i);
                result[i][j] = rank2[root] + 1;
                rank[i] = rank2[root] + 1;
                rank[j + m] = rank2[root] + 1;
            }
        }

        return result;
    }
};