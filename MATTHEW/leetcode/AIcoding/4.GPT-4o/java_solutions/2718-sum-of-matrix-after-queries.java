class Solution {
    public int[] matrixSumQueries(int n, int[][] queries) {
        long[] rowSum = new long[n];
        long[] colSum = new long[n];
        boolean[] rowVisited = new boolean[n];
        boolean[] colVisited = new boolean[n];
        long totalSum = 0;
        int[] result = new int[queries.length];

        for (int i = queries.length - 1; i >= 0; i--) {
            int type = queries[i][0];
            int index = queries[i][1];
            int value = queries[i][2];

            if (type == 0) {
                if (!rowVisited[index]) {
                    totalSum += value * (n - countVisited(colVisited));
                    rowVisited[index] = true;
                }
            } else {
                if (!colVisited[index]) {
                    totalSum += value * (n - countVisited(rowVisited));
                    colVisited[index] = true;
                }
            }
            result[i] = (int)(totalSum % 1000000007);
        }
        return result;
    }

    private int countVisited(boolean[] visited) {
        int count = 0;
        for (boolean v : visited) {
            if (v) count++;
        }
        return count;
    }
}