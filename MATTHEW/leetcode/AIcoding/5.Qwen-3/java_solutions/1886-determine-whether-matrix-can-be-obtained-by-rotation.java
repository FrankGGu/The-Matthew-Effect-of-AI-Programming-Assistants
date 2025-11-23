public class Solution {
    public boolean findRotation(int[][] mat, int[][] target) {
        if (isSame(mat, target)) {
            return true;
        }
        rotate(mat);
        if (isSame(mat, target)) {
            return true;
        }
        rotate(mat);
        if (isSame(mat, target)) {
            return true;
        }
        rotate(mat);
        return isSame(mat, target);
    }

    private void rotate(int[][] mat) {
        int n = mat.length;
        for (int i = 0; i < n / 2; i++) {
            for (int j = 0; j < (n + 1) / 2; j++) {
                int temp = mat[i][j];
                mat[i][j] = mat[n - 1 - j][i];
                mat[n - 1 - j][i] = mat[n - 1 - i][n - 1 - j];
                mat[n - 1 - i][n - 1 - j] = mat[j][n - 1 - i];
                mat[j][n - 1 - i] = temp;
            }
        }
    }

    private boolean isSame(int[][] a, int[][] b) {
        for (int i = 0; i < a.length; i++) {
            for (int j = 0; j < a[0].length; j++) {
                if (a[i][j] != b[i][j]) {
                    return false;
                }
            }
        }
        return true;
    }
}