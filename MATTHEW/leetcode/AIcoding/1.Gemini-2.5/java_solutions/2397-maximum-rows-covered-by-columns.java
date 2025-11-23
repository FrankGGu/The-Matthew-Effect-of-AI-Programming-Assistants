class Solution {
    public int maximumRows(int[][] mat, int numSelect) {
        int m = mat.length;
        int n = mat[0].length;

        int[] rowMasks = new int[m];
        for (int i = 0; i < m; i++) {
            int currentMask = 0;
            for (int j = 0; j < n; j++) {
                if (mat[i][j] == 1) {
                    currentMask |= (1 << j);
                }
            }
            rowMasks[i] = currentMask;
        }

        int maxCoveredRows = 0;

        for (int colSelectMask = 0; colSelectMask < (1 << n); colSelectMask++) {
            if (Integer.bitCount(colSelectMask) == numSelect) {
                int currentCoveredRows = 0;
                for (int rowMask : rowMasks) {
                    if ((rowMask & colSelectMask) == rowMask) {
                        currentCoveredRows++;
                    }
                }
                maxCoveredRows = Math.max(maxCoveredRows, currentCoveredRows);
            }
        }

        return maxCoveredRows;
    }
}