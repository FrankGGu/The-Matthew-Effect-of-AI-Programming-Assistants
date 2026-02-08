class Solution {
    public long matrixSumQueries(int n, int[][] queries) {
        long totalSum = 0;
        boolean[] rowsCovered = new boolean[n];
        boolean[] colsCovered = new boolean[n];
        int numRowsCovered = 0;
        int numColsCovered = 0;

        for (int i = queries.length - 1; i >= 0; i--) {
            int type = queries[i][0];
            int index = queries[i][1];
            int val = queries[i][2];

            if (type == 0) { // Row query
                if (!rowsCovered[index]) {
                    rowsCovered[index] = true;
                    numRowsCovered++;
                    totalSum += (long) val * (n - numColsCovered);
                }
            } else { // Column query
                if (!colsCovered[index]) {
                    colsCovered[index] = true;
                    numColsCovered++;
                    totalSum += (long) val * (n - numRowsCovered);
                }
            }
        }

        return totalSum;
    }
}