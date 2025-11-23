class Solution {
    public int[] findPeakGrid(int[][] mat) {
        int m = mat.length;
        int n = mat[0].length;
        int low = 0, high = m - 1;
        while (low <= high) {
            int mid = low + (high - low) / 2;
            int maxColIndex = 0;
            for (int i = 1; i < n; i++) {
                if (mat[mid][i] > mat[mid][maxColIndex]) {
                    maxColIndex = i;
                }
            }
            if (mid > 0 && mat[mid][maxColIndex] < mat[mid - 1][maxColIndex]) {
                high = mid - 1;
            } else if (mid < m - 1 && mat[mid][maxColIndex] < mat[mid + 1][maxColIndex]) {
                low = mid + 1;
            } else {
                return new int[]{mid, maxColIndex};
            }
        }
        return new int[]{-1, -1};
    }
}