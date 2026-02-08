class Solution {
    public int[] concatenate(int[][] mat) {
        if (mat == null || mat.length == 0) {
            return new int[0];
        }

        int m = mat.length;
        int n = mat[0].length;

        if (n == 0) { // Handle cases like {{}}
            return new int[0];
        }

        int[] result = new int[m * n];
        int index = 0;
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                result[index++] = mat[i][j];
            }
        }
        return result;
    }
}