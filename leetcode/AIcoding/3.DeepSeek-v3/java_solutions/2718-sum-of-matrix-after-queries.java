class Solution {
    public long matrixSumQueries(int n, int[][] queries) {
        boolean[] rowSeen = new boolean[n];
        boolean[] colSeen = new boolean[n];
        long sum = 0;
        int rowCount = 0, colCount = 0;

        for (int i = queries.length - 1; i >= 0; i--) {
            int type = queries[i][0];
            int index = queries[i][1];
            int val = queries[i][2];

            if (type == 0) {
                if (!rowSeen[index]) {
                    rowSeen[index] = true;
                    sum += (long) val * (n - colCount);
                    rowCount++;
                }
            } else {
                if (!colSeen[index]) {
                    colSeen[index] = true;
                    sum += (long) val * (n - rowCount);
                    colCount++;
                }
            }
        }

        return sum;
    }
}