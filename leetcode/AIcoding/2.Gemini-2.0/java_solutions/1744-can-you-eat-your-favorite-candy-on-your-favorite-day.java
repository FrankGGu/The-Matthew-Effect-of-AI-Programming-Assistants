class Solution {
    public boolean[] canEat(int[] candiesCount, int[][] queries) {
        int n = candiesCount.length;
        long[] prefixSum = new long[n];
        prefixSum[0] = candiesCount[0];
        for (int i = 1; i < n; i++) {
            prefixSum[i] = prefixSum[i - 1] + candiesCount[i];
        }

        int q = queries.length;
        boolean[] result = new boolean[q];
        for (int i = 0; i < q; i++) {
            int type = queries[i][0];
            int day = queries[i][1];
            int cap = queries[i][2];

            long minEat = (long)day + 1;
            long maxEat = (long)(day + 1) * cap;

            long candiesBefore = (type == 0) ? 0 : prefixSum[type - 1];
            long candiesAvailable = prefixSum[type];

            if (minEat <= candiesAvailable && maxEat > candiesBefore) {
                result[i] = true;
            } else {
                result[i] = false;
            }
        }
        return result;
    }
}