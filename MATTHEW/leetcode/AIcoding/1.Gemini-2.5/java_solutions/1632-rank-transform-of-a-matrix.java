import java.util.*;

class Solution {
    public int[][] matrixRankTransform(int[][] matrix) {
        int m = matrix.length;
        int n = matrix[0].length;

        List<int[]> cells = new ArrayList<>();
        for (int r = 0; r < m; r++) {
            for (int c = 0; c < n; c++) {
                cells.add(new int[]{matrix[r][c], r, c});
            }
        }

        Collections.sort(cells, (a, b) -> a[0] - b[0]);

        int[][] ans = new int[m][n];
        int[] rowMaxRank = new int[m];
        int[] colMaxRank = new int[n];

        int i = 0;
        while (i < cells.size()) {
            int currentVal = cells.get(i)[0];
            List<int[]> currentGroup = new ArrayList<>();
            int j = i;
            while (j < cells.size() && cells.get(j)[0] == currentVal) {
                currentGroup.add(cells.get(j));
                j++;
            }
            i = j;

            DSU dsu = new DSU(m + n);
            for (int[] cellInfo : currentGroup) {
                int r = cellInfo[1];
                int c = cellInfo[2];
                dsu.union(r, m + c);
            }

            Map<Integer, Integer> componentMaxPrevRank = new HashMap<>();
            for (int[] cellInfo : currentGroup) {
                int r = cellInfo[1];
                int c = cellInfo[2];
                int root = dsu.find(r);
                int currentMax = Math.max(rowMaxRank[r], colMaxRank[c]);
                componentMaxPrevRank.put(root, Math.max(componentMaxPrevRank.getOrDefault(root, 0), currentMax));
            }

            for (int[] cellInfo : currentGroup) {
                int r = cellInfo[1];
                int c = cellInfo[2];
                int root = dsu.find(r);
                int rank = 1 + componentMaxPrevRank.get(root);
                ans[r][c] = rank;
            }

            for (int[] cellInfo : currentGroup) {
                int r = cellInfo[1];
                int c = cellInfo[2];
                rowMaxRank[r] = ans[r][c];
                colMaxRank[c] = ans[r][c];
            }
        }

        return ans;
    }

    private static class DSU {
        int[] parent;

        public DSU(int n) {
            parent = new int[n];
            for (int i = 0; i < n; i++) {
                parent[i] = i;
            }
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
            }
        }
    }
}