class Solution {
    class DSU {
        int[] parent;
        int count;

        public DSU(int n) {
            parent = new int[n];
            for (int i = 0; i < n; i++) {
                parent[i] = i;
            }
            count = n;
        }

        public int find(int i) {
            if (parent[i] == i) {
                return i;
            }
            return parent[i] = find(parent[i]);
        }

        public void union(int i, int j) {
            int rootI = find(i);
            int rootJ = find(j);
            if (rootI != rootJ) {
                parent[rootI] = rootJ;
                count--;
            }
        }
    }

    public int regionsBySlashes(String[] grid) {
        int N = grid.length;
        // Each 1x1 cell is divided into 4 parts:
        // 0: top triangle
        // 1: right triangle
        // 2: bottom triangle
        // 3: left triangle
        // Total elements for DSU: 4 * N * N
        DSU dsu = new DSU(4 * N * N);

        for (int r = 0; r < N; r++) {
            for (int c = 0; c < N; c++) {
                // Calculate the base index for the current cell (r, c)
                // This maps the 2D cell coordinate to a 1D index, then multiplies by 4
                // to account for the 4 parts within each cell.
                int base = 4 * (r * N + c);
                char slash = grid[r].charAt(c);

                // Handle internal connections within the current cell based on the slash character
                if (slash == ' ') {
                    // All 4 parts are connected
                    dsu.union(base + 0, base + 1);
                    dsu.union(base + 1, base + 2);
                    dsu.union(base + 2, base + 3);
                } else if (slash == '/') {
                    // Top (0) connects to Left (3)
                    // Right (1) connects to Bottom (2)
                    dsu.union(base + 0, base + 3);
                    dsu.union(base + 1, base + 2);
                } else if (slash == '\\') { // backslash
                    // Top (0) connects to Right (1)
                    // Left (3) connects to Bottom (2)
                    dsu.union(base + 0, base + 1);
                    dsu.union(base + 3, base + 2);
                }

                // Handle connections with adjacent cells
                // Connect bottom part of current cell to top part of cell below
                if (r + 1 < N) {
                    // Current cell's bottom part (2)
                    // Cell below's top part (0)
                    dsu.union(base + 2, 4 * ((r + 1) * N + c) + 0);
                }
                // Connect right part of current cell to left part of cell to its right
                if (c + 1 < N) {
                    // Current cell's right part (1)
                    // Cell to its right's left part (3)
                    dsu.union(base + 1, 4 * (r * N + (c + 1)) + 3);
                }
            }
        }

        // The final count in DSU represents the number of disjoint regions
        return dsu.count;
    }
}