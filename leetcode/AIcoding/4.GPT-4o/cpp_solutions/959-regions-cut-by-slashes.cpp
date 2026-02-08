class Solution {
public:
    int regionsBySlashes(vector<string>& grid) {
        int n = grid.size();
        vector<vector<int>> parent(n * 3, vector<int>(n * 3));
        iota(parent.begin(), parent.end(), 0);

        auto find = [&](int x) {
            if (parent[x] != x) {
                parent[x] = find(parent[x]);
            }
            return parent[x];
        };

        auto unionSets = [&](int x, int y) {
            parent[find(x)] = find(y);
        };

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                if (grid[i][j] == ' ' || grid[i][j] == '/') {
                    unionSets(i * 3 + j * 3 + 0, i * 3 + j * 3 + 1);
                    unionSets(i * 3 + j * 3 + 1, i * 3 + j * 3 + 2);
                }
                if (grid[i][j] == ' ' || grid[i][j] == '\\') {
                    unionSets(i * 3 + j * 3 + 0, i * 3 + (j + 1) * 3 + 2);
                    unionSets(i * 3 + (j + 1) * 3 + 1, i * 3 + (j + 1) * 3 + 2);
                }
            }
        }

        int regions = 0;
        for (int i = 0; i < n * 3; ++i) {
            for (int j = 0; j < n * 3; ++j) {
                if (find(i * n + j) == i * n + j) {
                    ++regions;
                }
            }
        }

        return regions;
    }
};