class UnionFind {
private:
    vector<int> parent;
    vector<int> rank;
    int count;
public:
    UnionFind(int n) : parent(n), rank(n, 0), count(n) {
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
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) {
            if (rank[rootX] < rank[rootY]) {
                parent[rootX] = rootY;
            } else {
                parent[rootY] = rootX;
                if (rank[rootX] == rank[rootY]) {
                    rank[rootX]++;
                }
            }
            count--;
        }
    }

    int getCount() const {
        return count;
    }
};

class Solution {
public:
    int removeStones(vector<vector<int>>& stones) {
        int n = stones.size();
        UnionFind uf(n);
        unordered_map<int, int> rowMap;
        unordered_map<int, int> colMap;

        for (int i = 0; i < n; ++i) {
            int row = stones[i][0];
            int col = stones[i][1];
            if (rowMap.count(row)) {
                uf.unite(i, rowMap[row]);
            } else {
                rowMap[row] = i;
            }
            if (colMap.count(col)) {
                uf.unite(i, colMap[col]);
            } else {
                colMap[col] = i;
            }
        }

        return n - uf.getCount();
    }
};