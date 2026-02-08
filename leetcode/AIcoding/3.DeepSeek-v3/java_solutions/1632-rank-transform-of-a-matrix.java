import java.util.*;

class Solution {
    public int[][] matrixRankTransform(int[][] matrix) {
        int m = matrix.length, n = matrix[0].length;
        int[][] res = new int[m][n];
        TreeMap<Integer, List<int[]>> map = new TreeMap<>();
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                map.computeIfAbsent(matrix[i][j], k -> new ArrayList<>()).add(new int[]{i, j});
            }
        }
        int[] rank = new int[m + n];
        for (List<int[]> cells : map.values()) {
            int[] parent = new int[m + n];
            for (int i = 0; i < parent.length; i++) {
                parent[i] = i;
            }
            int[] rankCopy = rank.clone();
            for (int[] cell : cells) {
                int x = cell[0], y = cell[1] + m;
                int px = find(parent, x), py = find(parent, y);
                if (px != py) {
                    parent[py] = px;
                    rankCopy[px] = Math.max(rankCopy[px], rankCopy[py]);
                }
            }
            for (int[] cell : cells) {
                int x = cell[0], y = cell[1];
                res[x][y] = rankCopy[find(parent, x)] + 1;
                rank[x] = res[x][y];
                rank[y + m] = res[x][y];
            }
        }
        return res;
    }

    private int find(int[] parent, int x) {
        if (parent[x] != x) {
            parent[x] = find(parent, parent[x]);
        }
        return parent[x];
    }
}