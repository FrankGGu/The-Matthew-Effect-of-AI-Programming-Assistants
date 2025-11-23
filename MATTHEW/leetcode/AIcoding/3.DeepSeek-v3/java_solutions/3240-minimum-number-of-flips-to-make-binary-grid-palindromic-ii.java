class Solution {
    public int minFlips(int[][] mat) {
        int m = mat.length;
        int n = mat[0].length;
        int flips = 0;

        for (int i = 0; i < m / 2; i++) {
            for (int j = 0; j < n; j++) {
                int mirrorI = m - 1 - i;
                int mirrorJ = n - 1 - j;
                if (mat[i][j] != mat[mirrorI][mirrorJ]) {
                    flips++;
                }
            }
        }

        if (m % 2 == 1) {
            int midRow = m / 2;
            for (int j = 0; j < n / 2; j++) {
                int mirrorJ = n - 1 - j;
                if (mat[midRow][j] != mat[midRow][mirrorJ]) {
                    flips++;
                }
            }
        }

        return flips;
    }
}