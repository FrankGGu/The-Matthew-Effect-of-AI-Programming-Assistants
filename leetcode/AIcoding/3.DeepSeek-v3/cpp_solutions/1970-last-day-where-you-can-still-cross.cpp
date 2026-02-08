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
        }
    }

    bool connected(int x, int y) {
        return find(x) == find(y);
    }
};

class Solution {
public:
    int latestDayToCross(int row, int col, vector<vector<int>>& cells) {
        UnionFind uf(row * col + 2);
        vector<vector<int>> grid(row, vector<int>(col, 1));
        vector<pair<int, int>> directions = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
        int top = row * col;
        int bottom = row * col + 1;

        for (int i = cells.size() - 1; i >= 0; --i) {
            int r = cells[i][0] - 1;
            int c = cells[i][1] - 1;
            grid[r][c] = 0;
            int index = r * col + c;

            if (r == 0) {
                uf.unite(index, top);
            }
            if (r == row - 1) {
                uf.unite(index, bottom);
            }

            for (auto& dir : directions) {
                int nr = r + dir.first;
                int nc = c + dir.second;
                if (nr >= 0 && nr < row && nc >= 0 && nc < col && grid[nr][nc] == 0) {
                    int nindex = nr * col + nc;
                    uf.unite(index, nindex);
                }
            }

            if (uf.connected(top, bottom)) {
                return i;
            }
        }
        return -1;
    }
};