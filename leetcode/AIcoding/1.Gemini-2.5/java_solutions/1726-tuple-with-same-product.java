import java.util.HashMap;
import java.util.Map;

class Solution {
    public int tupleSameProduct(int[] nums) {
        int n = nums.length;
        Map<Integer, Integer> productCounts = new HashMap<>();

        for (int i = 0; i < n; i++) {
            for (int j = i + 1; j < n; j++) {
                int product = nums[i] * nums[j];
                productCounts.put(product, productCounts.getOrDefault(product, 0) + 1);
            }
        }

        long totalTuples = 0;
        for (int count : productCounts.values()) {
            if (count > 1) {
                // If there are 'count' pairs that result in the same product,
                // we need to choose 2 distinct pairs from them.
                // The number of ways to choose 2 pairs is count * (count - 1) / 2.
                // Each such choice (e.g., (a,b) and (c,d)) forms a set of 4 distinct numbers {a,b,c,d}
                // such that a*b = c*d.
                // For each set, there are 8 possible tuples:
                // (a,b,c,d), (a,b,d,c), (b,a,c,d), (b,a,d,c),
                // (c,d,a,b), (c,d,b,a), (d,c,a,b), (d,c,b,a).
                totalTuples += (long) count * (count - 1) / 2 * 8;
            }
        }

        return (int) totalTuples;
    }
}