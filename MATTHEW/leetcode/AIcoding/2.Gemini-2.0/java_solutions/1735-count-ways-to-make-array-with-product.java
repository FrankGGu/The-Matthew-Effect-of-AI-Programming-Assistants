class Solution {
    private static final int MOD = 1000000007;

    public int[] waysToFillArray(int[][] queries) {
        int maxN = 0;
        for (int[] query : queries) {
            maxN = Math.max(maxN, query[0]);
        }

        long[][] combinations = new long[maxN + 31][31];
        for (int i = 0; i < combinations.length; i++) {
            combinations[i][0] = 1;
            for (int j = 1; j < Math.min(i + 1, combinations[i].length); j++) {
                combinations[i][j] = (combinations[i - 1][j - 1] + combinations[i - 1][j]) % MOD;
            }
        }

        int[] result = new int[queries.length];
        for (int i = 0; i < queries.length; i++) {
            int n = queries[i][0];
            int k = queries[i][1];
            long ways = 1;

            for (int j = 2; j * j <= k; j++) {
                int count = 0;
                while (k % j == 0) {
                    k /= j;
                    count++;
                }
                if (count > 0) {
                    ways = (ways * combinations[n + count - 1][count]) % MOD;
                }
            }

            if (k > 1) {
                ways = (ways * combinations[n][1]) % MOD;
            }

            result[i] = (int) ways;
        }

        return result;
    }
}