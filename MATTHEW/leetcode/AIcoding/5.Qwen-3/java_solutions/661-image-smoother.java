public class Solution {
    public int[][] imageSmoother(int[][] img) {
        int rows = img.length;
        int cols = img[0].length;
        int[][] result = new int[rows][cols];

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                int sum = 0;
                int count = 0;

                for (int x = Math.max(0, i - 1); x <= Math.min(rows - 1, i + 1); x++) {
                    for (int y = Math.max(0, j - 1); y <= Math.min(cols - 1, j + 1); y++) {
                        sum += img[x][y];
                        count++;
                    }
                }

                result[i][j] = sum / count;
            }
        }

        return result;
    }
}