class Solution {
    public int regionsBySlashes(String[] grid) {
        int n = grid.length;
        int size = 3 * n;
        int[] parent = new int[size * size];
        for (int i = 0; i < size * size; i++) {
            parent[i] = i;
        }

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                int base = (i * 3 * size) + (j * 3);
                if (grid[i].charAt(j) == '/') {
                    union(parent, base, base + 1, size);
                    union(parent, base + 2, base + 3, size);
                } else if (grid[i].charAt(j) == '\\') {
                    union(parent, base, base + 3, size);
                    union(parent, base + 1, base + 2, size);
                } else {
                    union(parent, base, base + 1, size);
                    union(parent, base + 1, base + 2, size);
                    union(parent, base + 2, base + 3, size);
                }
            }
        }

        for (int i = 0; i < size; i++) {
            for (int j = 0; j < size; j++) {
                if (i == 0 || i == size - 1 || j == 0 || j == size - 1) {
                    union(parent, 0, i * size + j, size);
                }
            }
        }

        int count = 0;
        for (int i = 0; i < size * size; i++) {
            if (find(parent, i) == i) {
                count++;
            }
        }
        return count;
    }

    private int find(int[] parent, int x) {
        if (parent[x] != x) {
            parent[x] = find(parent, parent[x]);
        }
        return parent[x];
    }

    private void union(int[] parent, int x, int y, int size) {
        x = find(parent, x);
        y = find(parent, y);
        if (x != y) {
            parent[x] = y;
        }
    }
}