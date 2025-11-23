class Solution {
    public long matrixSumQueries(int n, int[][] queries) {
        long sum = 0;
        boolean[] row = new boolean[n];
        boolean[] col = new boolean[n];
        int rowFilled = 0;
        int colFilled = 0;

        for (int i = queries.length - 1; i >= 0; i--) {
            int type = queries[i][0];
            int index = queries[i][1];
            int val = queries[i][2];

            if (type == 0) {
                if (!row[index]) {
                    sum += (long) val * (n - colFilled);
                    row[index] = true;
                    rowFilled++;
                }
            } else {
                if (!col[index]) {
                    sum += (long) val * (n - rowFilled);
                    col[index] = true;
                    colFilled++;
                }
            }
        }

        return sum;
    }
}