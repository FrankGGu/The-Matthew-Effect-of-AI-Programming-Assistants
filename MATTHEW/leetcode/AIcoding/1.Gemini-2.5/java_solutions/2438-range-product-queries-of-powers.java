import java.util.ArrayList;
import java.util.List;

class Solution {
    public int[] productQueries(int n, int[][] queries) {
        List<Long> powers = new ArrayList<>();

        for (int i = 0; i < 31; i++) {
            if (((n >> i) & 1) == 1) {
                powers.add(1L << i);
            }
        }

        int[] results = new int[queries.length];
        long MOD = 1_000_000_007L;

        for (int k = 0; k < queries.length; k++) {
            int left = queries[k][0];
            int right = queries[k][1];

            long currentProduct = 1;
            for (int i = left; i <= right; i++) {
                currentProduct = (currentProduct * powers.get(i)) % MOD;
            }
            results[k] = (int) currentProduct;
        }

        return results;
    }
}