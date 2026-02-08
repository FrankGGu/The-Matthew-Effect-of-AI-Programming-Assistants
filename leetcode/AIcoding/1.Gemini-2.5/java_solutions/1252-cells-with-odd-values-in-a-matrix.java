class Solution {
    public int oddCells(int m, int n, int[][] indices) {
        int[] rowIncrements = new int[m];
        int[] colIncrements = new int[n];

        for (int[] index : indices) {
            rowIncrements[index[0]]++;
            colIncrements[index[1]]++;
        }

        int oddRowsCount = 0;
        for (int r = 0; r < m; r++) {
            if (rowIncrements[r] % 2 != 0) {
                oddRowsCount++;
            }
        }

        int oddColsCount = 0;
        for (int c = 0; c < n; c++) {
            if (colIncrements[c] % 2 != 0) {
                oddColsCount++;
            }
        }

        int evenRowsCount = m - oddRowsCount;
        int evenColsCount = n - oddColsCount;

        return oddRowsCount * evenColsCount + evenRowsCount * oddColsCount;
    }
}