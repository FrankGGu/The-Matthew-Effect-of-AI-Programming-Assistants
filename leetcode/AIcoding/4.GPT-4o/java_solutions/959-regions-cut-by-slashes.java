class Solution {
    public int regionsBySlashes(String[] grid) {
        int n = grid.length;
        UnionFind uf = new UnionFind(n * n * 4);

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                int index = i * n + j;
                if (grid[i].charAt(j) == '/') {
                    uf.union(index * 4, index * 4 + 3);
                    uf.union(index * 4 + 1, index * 4 + 2);
                } else if (grid[i].charAt(j) == '\\') {
                    uf.union(index * 4, index * 4 + 1);
                    uf.union(index * 4 + 2, index * 4 + 3);
                } else {
                    uf.union(index * 4, index * 4 + 1);
                    uf.union(index * 4 + 1, index * 4 + 2);
                    uf.union(index * 4 + 2, index * 4 + 3);
                }

                if (j < n - 1) {
                    uf.union(index * 4 + 2, (index + 1) * 4 + 0);
                }
                if (i < n - 1) {
                    uf.union(index * 4 + 3, (index + n) * 4 + 1);
                }
            }
        }

        return uf.getCount();
    }
}

class UnionFind {
    private int[] parent;
    private int count;

    public UnionFind(int size) {
        parent = new int[size];
        for (int i = 0; i < size; i++) {
            parent[i] = i;
        }
        count = size;
    }

    public int find(int x) {
        if (parent[x] != x) {
            parent[x] = find(parent[x]);
        }
        return parent[x];
    }

    public void union(int x, int y) {
        int rootX = find(x);
        int rootY = find(y);
        if (rootX != rootY) {
            parent[rootX] = rootY;
            count--;
        }
    }

    public int getCount() {
        return count;
    }
}