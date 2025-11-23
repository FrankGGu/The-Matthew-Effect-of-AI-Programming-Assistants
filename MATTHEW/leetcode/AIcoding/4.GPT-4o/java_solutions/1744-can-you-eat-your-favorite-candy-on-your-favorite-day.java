class Solution {
    public boolean[] canEat(int[] candiesCount, int[][] queries) {
        int n = candiesCount.length;
        long[] prefixSum = new long[n];
        prefixSum[0] = candiesCount[0];
        for (int i = 1; i < n; i++) {
            prefixSum[i] = prefixSum[i - 1] + candiesCount[i];
        }
        boolean[] result = new boolean[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int favoriteType = queries[i][0];
            int favoriteDay = queries[i][1];
            int dailyCap = queries[i][2];
            long minCandies = (long) favoriteDay + 1;
            long maxCandies = (long) (favoriteDay + 1) * dailyCap;
            long totalCandies = favoriteType == 0 ? prefixSum[favoriteType] : prefixSum[favoriteType] - prefixSum[favoriteType - 1];
            long totalCandiesBefore = favoriteType > 0 ? prefixSum[favoriteType - 1] : 0;
            result[i] = minCandies <= totalCandies && maxCandies > totalCandiesBefore;
        }
        return result;
    }
}