class Solution {
    public int[][] construct2DArray(int[] original, int m, int n) {
        if (original.length != m * n) {
            return new int[0][0];
        }

        int[][] result = new int[m][n];
        for (int k = 0; k < original.length; k++) {
            int r = k / n;
            int c = k % n;
            result[r][c] = original[k];
        }

        return result;
    }
}