#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
private:
    int find(vector<int>& parent, int x) {
        if (parent[x] != x) {
            parent[x] = find(parent, parent[x]);
        }
        return parent[x];
    }

    void unite(vector<int>& parent, vector<int>& rank, int x, int y) {
        int rootX = find(parent, x);
        int rootY = find(parent, y);
        if (rootX != rootY) {
            if (rank[rootX] > rank[rootY]) {
                parent[rootY] = rootX;
            } else {
                parent[rootX] = rootY;
                if (rank[rootX] == rank[rootY]) {
                    rank[rootY]++;
                }
            }
        }
    }

public:
    int regionsBySlashes(vector<string>& grid) {
        int n = grid.size();
        int size = n * n * 4;
        vector<int> parent(size);
        vector<int> rank(size, 1);

        for (int i = 0; i < size; ++i) {
            parent[i] = i;
        }

        for (int i = 0; i < n; ++i) {
            for (int j = 0; j < n; ++j) {
                int base = (i * n + j) * 4;
                char c = grid[i][j];

                if (c == '/') {
                    unite(parent, rank, base, base + 3);
                    unite(parent, rank, base + 1, base + 2);
                } else if (c == '\\') {
                    unite(parent, rank, base, base + 1);
                    unite(parent, rank, base + 2, base + 3);
                } else {
                    unite(parent, rank, base, base + 1);
                    unite(parent, rank, base + 1, base + 2);
                    unite(parent, rank, base + 2, base + 3);
                }

                if (i > 0) {
                    int upBase = ((i - 1) * n + j) * 4;
                    unite(parent, rank, base, upBase + 2);
                }

                if (j > 0) {
                    int leftBase = (i * n + (j - 1)) * 4;
                    unite(parent, rank, base + 1, leftBase + 3);
                }
            }
        }

        int result = 0;
        vector<bool> visited(size, false);

        for (int i = 0; i < size; ++i) {
            int root = find(parent, i);
            if (!visited[root]) {
                visited[root] = true;
                ++result;
            }
        }

        return result;
    }
};