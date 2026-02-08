class Solution {
    public int firstCompleteIndex(int[] arr, int[][] mat) {
        int m = mat.length;
        int n = mat[0].length;
        int[] rowCount = new int[m];
        int[] colCount = new int[n];
        int[][] pos = new int[m * n + 1][2];

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                pos[mat[i][j]][0] = i;
                pos[mat[i][j]][1] = j;
            }
        }

        for (int i = 0; i < arr.length; i++) {
            int row = pos[arr[i]][0];
            int col = pos[arr[i]][1];
            rowCount[row]++;
            colCount[col]++;

            if (rowCount[row] == n || colCount[col] == m) {
                return i;
            }
        }

        return -1;
    }
}