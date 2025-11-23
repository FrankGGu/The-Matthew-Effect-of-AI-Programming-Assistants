class Solution {
public:
    vector<int> parent;
    vector<int> size;
    vector<int> rank;

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
            size[yRoot] += size[xRoot];
        } else if (rank[xRoot] > rank[yRoot]) {
            parent[yRoot] = xRoot;
            size[xRoot] += size[yRoot];
        } else {
            parent[yRoot] = xRoot;
            size[xRoot] += size[yRoot];
            rank[xRoot]++;
        }
    }

    vector<int> hitBricks(vector<vector<int>>& grid, vector<vector<int>>& hits) {
        int m = grid.size();
        int n = grid[0].size();
        int total = m * n;
        parent.resize(total + 1);
        size.resize(total + 1, 1);
        rank.resize(total + 1, 0);
        for (int i = 0; i <= total; ++i) {
            parent[i] = i;
        }
        vector<vector<int>> copy = grid;
        for (auto& hit : hits) {
            int x = hit[0], y = hit[1];
            if (copy[x][y] == 1) {
                copy[x][y] = 0;
            }
        }
        for (int i = 0; i < m; ++i) {
            for (int j = 0; j < n; ++j) {
                if (copy[i][j] == 1) {
                    int index = i * n + j;
                    if (i == 0) {
                        unionSet(index, total);
                    }
                    if (i > 0 && copy[i-1][j] == 1) {
                        unionSet(index, (i-1)*n + j);
                    }
                    if (j > 0 && copy[i][j-1] == 1) {
                        unionSet(index, i*n + j-1);
                    }
                }
            }
        }
        vector<int> res(hits.size(), 0);
        int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        for (int k = hits.size() - 1; k >= 0; --k) {
            int i = hits[k][0], j = hits[k][1];
            if (grid[i][j] == 0) continue;
            int prevSize = size[find(total)];
            if (i == 0) {
                unionSet(i * n + j, total);
            }
            for (auto& dir : dirs) {
                int ni = i + dir[0];
                int nj = j + dir[1];
                if (ni >= 0 && ni < m && nj >= 0 && nj < n && copy[ni][nj] == 1) {
                    unionSet(i * n + j, ni * n + nj);
                }
            }
            copy[i][j] = 1;
            int currSize = size[find(total)];
            res[k] = max(0, currSize - prevSize - 1);
        }
        return res;
    }
};