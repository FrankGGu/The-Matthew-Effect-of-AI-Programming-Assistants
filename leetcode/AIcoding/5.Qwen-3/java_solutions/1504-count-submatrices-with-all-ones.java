public class Solution {
    public int numSubmat(int[][] mat) {
        int n = mat.length;
        int m = mat[0].length;
        int count = 0;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < m; j++) {
                if (mat[i][j] == 1) {
                    int minRow = i;
                    int minCol = j;
                    while (minRow < n && mat[minRow][j] == 1) {
                        minCol = j;
                        while (minCol < m && mat[minRow][minCol] == 1) {
                            count++;
                            minCol++;
                        }
                        minRow++;
                    }
                }
            }
        }

        return count;
    }
}