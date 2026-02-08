class Solution {
public:
    int regionsBySlashes(vector<string>& grid) {
        int n = grid.size();
        vector<int> parent(4 * n * n);
        for (int i = 0; i < 4 * n * n; ++i) {
            parent[i] = i;
        }

        function<int(int)> find = [&](int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        };

        auto unite = [&](int x, int y) {
            x = find(x);
            y = find(y);
            if (x != y) {
                parent[x] = y;
            }
        };

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                int idx = i * n + j;
                if (grid[i][j] == '/') {
                    unite(idx * 4 + 0, idx * 4 + 3);
                    unite(idx * 4 + 1, idx * 4 + 2);
                } else if (grid[i][j] == '\\') {
                    unite(idx * 4 + 0, idx * 4 + 1);
                    unite(idx * 4 + 2, idx * 4 + 3);
                } else {
                    unite(idx * 4 + 0, idx * 4 + 1);
                    unite(idx * 4 + 2, idx * 4 + 3);
                    unite(idx * 4 + 0, idx * 4 + 2);
                }

                if (i > 0) {
                    unite(idx * 4 + 0, ((i - 1) * n + j) * 4 + 2);
                }
                if (j > 0) {
                    unite(idx * 4 + 3, (i * n + (j - 1)) * 4 + 1);
                }
            }
        }

        int count = 0;
        for (int i = 0; i < 4 * n * n; ++i) {
            if (parent[i] == i) {
                count++;
            }
        }

        return count;
    }
};