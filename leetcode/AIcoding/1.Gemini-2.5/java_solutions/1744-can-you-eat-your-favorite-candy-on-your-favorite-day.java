class Solution {
    public boolean[] canEat(int[] candiesCount, int[][] queries) {
        int n = candiesCount.length;
        long[] prefixSum = new long[n + 1];
        for (int i = 0; i < n; i++) {
            prefixSum[i + 1] = prefixSum[i] + candiesCount[i];
        }

        boolean[] result = new boolean[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int candyType = queries[i][0];
            int day = queries[i][1];
            int dailyCap = queries[i][2];

            long candyTypeMinIdx = prefixSum[candyType];
            long candyTypeMaxIdx = prefixSum[candyType + 1] - 1;

            long possibleMinIdxOnDay = day;
            long possibleMaxIdxOnDay = (long) (day + 1) * dailyCap - 1;

            boolean canEat = (possibleMinIdxOnDay <= candyTypeMaxIdx) && (candyTypeMinIdx <= possibleMaxIdxOnDay);
            result[i] = canEat;
        }

        return result;
    }
}