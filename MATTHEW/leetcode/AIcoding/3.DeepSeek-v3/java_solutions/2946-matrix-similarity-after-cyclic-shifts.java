class Solution {
    public boolean areSimilar(int[][] mat, int k) {
        int m = mat.length;
        int n = mat[0].length;
        int[][] original = new int[m][n];
        for (int i = 0; i < m; i++) {
            System.arraycopy(mat[i], 0, original[i], 0, n);
        }
        for (int i = 0; i < m; i++) {
            int[] row = mat[i];
            int shift = k % n;
            if (i % 2 == 0) {
                reverse(row, 0, shift - 1);
                reverse(row, shift, n - 1);
                reverse(row, 0, n - 1);
            } else {
                reverse(row, 0, n - shift - 1);
                reverse(row, n - shift, n - 1);
                reverse(row, 0, n - 1);
            }
        }
        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                if (original[i][j] != mat[i][j]) {
                    return false;
                }
            }
        }
        return true;
    }

    private void reverse(int[] arr, int start, int end) {
        while (start < end) {
            int temp = arr[start];
            arr[start] = arr[end];
            arr[end] = temp;
            start++;
            end--;
        }
    }
}