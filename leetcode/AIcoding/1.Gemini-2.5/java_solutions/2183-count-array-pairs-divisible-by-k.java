import java.util.HashMap;
import java.util.Map;

class Solution {

    // Helper GCD function using Euclidean algorithm
    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    public long countPairs(int[] nums, int k) {
        // Map to store frequencies of gcd(num, k) values.
        // Keys are divisors of k (result of gcd(num, k)), values are their counts in nums.
        Map<Integer, Integer> freqGcd = new HashMap<>();

        // Populate freqGcd map by iterating through nums
        for (int num : nums) {
            int currentGcd = gcd(num, k);
            freqGcd.merge(currentGcd, 1, Integer::sum);
        }

        long totalPairs = 0; // This will count (i,j) and (j,i) for i!=j, and (i,i) for all i

        // Iterate through all pairs of gcd values (g_a, g_b) encountered in nums.
        // The property (nums[i] * nums[j]) % k == 0 is equivalent to
        // (gcd(nums[i], k) * gcd(nums[j], k)) % k == 0.
        for (Map.Entry<Integer, Integer> entryA : freqGcd.entrySet()) {
            int g_a = entryA.getKey();
            int count_a = entryA.getValue();

            for (Map.Entry<Integer, Integer> entryB : freqGcd.entrySet()) {
                int g_b = entryB.getKey();
                int count_b = entryB.getValue();

                // Check the condition (g_a * g_b) % k == 0.
                // Use long for the product to prevent overflow before modulo.
                if (((long)g_a * g_b) % k == 0) {
                    // If the condition holds, any of the `count_a` numbers whose gcd with k is `g_a`
                    // can form a pair with any of the `count_b` numbers whose gcd with k is `g_b`.
                    totalPairs += (long)count_a * count_b;
                }
            }
        }

        // `selfPairs` will count the number of elements `x` in `nums` such that `(x * x) % k == 0`.
        // These correspond to the (i,i) pairs that satisfy the condition.
        long selfPairs = 0; 
        for (Map.Entry<Integer, Integer> entry : freqGcd.entrySet()) {
            int g = entry.getKey();
            int count = entry.getValue();

            // Check if (g * g) % k == 0.
            // If it is, then any number `x` with gcd(x, k) = g will satisfy (x * x) % k == 0.
            if (((long)g * g) % k == 0) {
                // Each of the `count` numbers forms a valid self-pair (nums[x], nums[x]).
                selfPairs += count;
            }
        }

        // The `totalPairs` variable currently counts:
        // 1. (i, j) where i < j and (nums[i] * nums[j]) % k == 0
        // 2. (j, i) where i < j and (nums[j] * nums[i]) % k == 0 (these are counted as distinct by the nested loop)
        // 3. (i, i) where (nums[i] * nums[i]) % k == 0
        //
        // We need only pairs (i, j) with i < j.
        // So, we subtract the `selfPairs` (which are the (i,i) pairs that satisfied the condition)
        // and then divide by 2 to account for (i,j) and (j,i) being counted twice.
        return (totalPairs - selfPairs) / 2;
    }
}