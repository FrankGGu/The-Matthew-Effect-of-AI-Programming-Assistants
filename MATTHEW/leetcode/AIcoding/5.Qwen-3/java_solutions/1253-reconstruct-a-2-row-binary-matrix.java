public class Solution {
    public int[][] findMatrix(int[] arr) {
        int n = arr.length;
        int[][] result = new int[2][n];
        int row0 = 0, row1 = 0;

        for (int i = 0; i < n; i++) {
            if (arr[i] == 0) {
                result[0][row0++] = i;
            } else {
                result[1][row1++] = i;
            }
        }

        return result;
    }
}