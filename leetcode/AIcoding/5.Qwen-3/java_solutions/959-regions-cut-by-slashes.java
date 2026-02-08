public class Solution {

import java.util.*;

public class Solution {
    public int regionsBySlashes(String[] grid) {
        int n = grid.length;
        int[][] parent = new int[n * 3][n * 3];

        for (int i = 0; i < n * 3; i++) {
            for (int j = 0; j < n * 3; j++) {
                parent[i][j] = i * n * 3 + j;
            }
        }

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                char c = grid[i].charAt(j);
                if (c == '/') {
                    union(parent, i * 3, j * 3 + 2, i * 3 + 1, j * 3 + 1);
                    union(parent, i * 3 + 1, j * 3 + 1, i * 3 + 2, j * 3);
                } else if (c == '\\') {
                    union(parent, i * 3, j * 3, i * 3 + 1, j * 3 + 1);
                    union(parent, i * 3 + 1, j * 3 + 1, i * 3 + 2, j * 3 + 2);
                }
            }
        }

        Set<Integer> roots = new HashSet<>();
        for (int i = 0; i < n * 3; i++) {
            for (int j = 0; j < n * 3; j++) {
                roots.add(find(parent, i, j));
            }
        }

        return roots.size();
    }

    private int find(int[][] parent, int i, int j) {
        if (parent[i][j] != i * parent.length + j) {
            parent[i][j] = find(parent, parent[i][j] / parent.length, parent[i][j] % parent.length);
        }
        return parent[i][j];
    }

    private void union(int[][] parent, int i1, int j1, int i2, int j2) {
        int root1 = find(parent, i1, j1);
        int root2 = find(parent, i2, j2);
        if (root1 != root2) {
            parent[root1 / parent.length][root1 % parent.length] = root2;
        }
    }
}
}