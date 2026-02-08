public class Solution {
    public int[] findPeakGrid(int[][] mat) {
        int n = mat.length, m = mat[0].length;
        int left = 0, right = m - 1;

        while (left < right) {
            int mid = left + (right - left) / 2;
            int maxRow = 0;
            for (int i = 0; i < n; i++) {
                if (mat[i][mid] > mat[maxRow][mid]) {
                    maxRow = i;
                }
            }
            if (mid < m - 1 && mat[maxRow][mid] < mat[maxRow][mid + 1]) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        int maxRow = 0;
        for (int i = 0; i < n; i++) {
            if (mat[i][left] > mat[maxRow][left]) {
                maxRow = i;
            }
        }

        return new int[] {maxRow, left};
    }
}