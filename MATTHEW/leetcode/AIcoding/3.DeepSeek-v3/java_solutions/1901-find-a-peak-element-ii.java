class Solution {
    public int[] findPeakGrid(int[][] mat) {
        int m = mat.length;
        int n = mat[0].length;
        int low = 0, high = m - 1;

        while (low <= high) {
            int mid = low + (high - low) / 2;
            int maxCol = 0;
            for (int j = 0; j < n; j++) {
                if (mat[mid][j] > mat[mid][maxCol]) {
                    maxCol = j;
                }
            }

            boolean isPeak = true;
            if (mid > 0 && mat[mid][maxCol] < mat[mid - 1][maxCol]) {
                isPeak = false;
                high = mid - 1;
            } else if (mid < m - 1 && mat[mid][maxCol] < mat[mid + 1][maxCol]) {
                isPeak = false;
                low = mid + 1;
            }

            if (isPeak) {
                return new int[]{mid, maxCol};
            }
        }

        return new int[]{-1, -1};
    }
}