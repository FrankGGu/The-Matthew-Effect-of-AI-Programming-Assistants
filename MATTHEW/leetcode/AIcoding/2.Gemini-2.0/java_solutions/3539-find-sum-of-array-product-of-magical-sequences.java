import java.util.Arrays;

class Solution {
    private static final int MOD = 1000000007;

    public int sumOfArrayProducts(int n, int m, int[] queries) {
        long totalSum = 0;
        for (int[] query : generateSequences(n, m, queries)) {
            long product = 1;
            for (int num : query) {
                product = (product * num) % MOD;
            }
            totalSum = (totalSum + product) % MOD;
        }
        return (int) totalSum;
    }

    private int[][] generateSequences(int n, int m, int[] queries) {
        int[][] result = new int[queries.length][n];
        for (int i = 0; i < queries.length; i++) {
            int[] sequence = new int[n];
            for (int j = 0; j < n; j++) {
                sequence[j] = (j + 1) * queries[i];
            }
            result[i] = sequence;
        }
        return result;
    }
}