class Solution {
    public int[][] average(int[][] image) {
        int m = image.length;
        int n = image[0].length;
        int[][] result = new int[m][n];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int sum = 0;
                int count = 0;
                for (int x = Math.max(0, i - 1); x <= Math.min(m - 1, i + 1); x++) {
                    for (int y = Math.max(0, j - 1); y <= Math.min(n - 1, j + 1); y++) {
                        sum += image[x][y];
                        count++;
                    }
                }
                result[i][j] = sum / count;
            }
        }

        return result;
    }
}