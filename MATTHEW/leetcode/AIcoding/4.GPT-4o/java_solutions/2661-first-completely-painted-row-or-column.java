class Solution {
    public int firstCompleteIndex(int[] rows, int[] cols) {
        int m = rows.length, n = cols.length;
        boolean[] rowPainted = new boolean[m];
        boolean[] colPainted = new boolean[n];
        int[] rowCount = new int[m];
        int[] colCount = new int[n];

        for (int i = 0; i < m; i++) {
            rowCount[rows[i]]++;
            rowPainted[rows[i]] = true;
            if (rowCount[rows[i]] == n) return i;

            colCount[cols[i]]++;
            colPainted[cols[i]] = true;
            if (colCount[cols[i]] == m) return i;
        }

        return -1;
    }
}