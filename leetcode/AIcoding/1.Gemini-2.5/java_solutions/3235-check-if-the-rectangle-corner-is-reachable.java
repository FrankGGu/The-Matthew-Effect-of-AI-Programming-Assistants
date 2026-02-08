import java.util.Arrays;

class DSU {
    int[] parent;
    int[] flags; // Bitmask: 1 (left), 2 (right), 4 (bottom), 8 (top)

    DSU(int n) {
        parent = new int[n];
        flags = new int[n]; 
        for (int i = 0; i < n; i++) {
            parent[i] = i;
        }
    }

    int find(int i) {
        if (parent[i] == i) {
            return i;
        }
        return parent[i] = find(parent[i]);
    }

    void union(int i, int j) {
        int rootI = find(i);
        int rootJ = find(j);
        if (rootI != rootJ) {
            parent[rootJ] = rootI;
            flags[rootI] |= flags[rootJ];
        }
    }
}

class Solution {
    public boolean canReachCorner(int x, int y, int[][] circles) {
        long x1 = 0, y1 = 0;
        long x2 = x, y2 = y;
        int n = circles.length;

        DSU dsu = new DSU(n);

        for (int i = 0; i < n; i++) {
            long cx = circles[i][0];
            long cy = circles[i][1];
            long r = circles[i][2];

            if (cx - r <= x1) { 
                dsu.flags[i] |= 1; // Touches left boundary (x=0)
            }
            if (cx + r >= x2) { 
                dsu.flags[i] |= 2; // Touches right boundary (x=X)
            }
            if (cy - r <= y1) { 
                dsu.flags[i] |= 4; // Touches bottom boundary (y=0)
            }
            if (cy + r >= y2) { 
                dsu.flags[i] |= 8; // Touches top boundary (y=Y)
            }
        }

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                long cx1 = circles[i][0];
                long cy1 = circles[i][1];
                long r1 = circles[i][2];

                long cx2 = circles[j][0];
                long cy2 = circles[j][1];
                long r2 = circles[j][2];

                long dx = cx1 - cx2;
                long dy = cy1 - cy2;
                long distSq = dx * dx + dy * dy;

                long rSum = r1 + r2;
                long rSumSq = rSum * rSum;

                if (distSq <= rSumSq) {
                    dsu.union(i, j);
                }
            }
        }

        for (int i = 0; i < n; i++) {
            if (dsu.parent[i] == i) { 
                int currentFlags = dsu.flags[i];

                // Check for horizontal cut: connects left (bit 1) and right (bit 2)
                if (((currentFlags & 1) != 0 && (currentFlags & 2) != 0)) {
                    return false;
                }
                // Check for vertical cut: connects bottom (bit 4) and top (bit 8)
                if (((currentFlags & 4) != 0 && (currentFlags & 8) != 0)) {
                    return false;
                }
            }
        }

        return true;
    }
}