import java.util.HashMap;
import java.util.Map;

class Solution {
    public int sumOfSquares(int[] nums) {
        int N = nums.length;
        long totalSum = 0;
        long MOD = 1_000_000_007; // 10^9 + 7

        // Map to store the last seen index of each number
        Map<Integer, Integer> lastSeen = new HashMap<>();

        for (int i = 0; i < N; i++) {
            int num = nums[i];

            // Determine the previous index of 'num'. If not seen before, it's -1.
            long prev_idx = -1;
            if (lastSeen.containsKey(num)) {
                prev_idx = lastSeen.get(num);
            }

            // Calculate num^2 modulo MOD.
            // (long)num * num ensures the multiplication is done using long
            // before taking modulo, preventing potential overflow if num*num exceeds Integer.MAX_VALUE.
            long sq_num = ((long)num * num) % MOD; 

            // Calculate the number of valid left endpoints (L) for which 'num' at index 'i'
            // is the first occurrence of its value in the subarray [L, i].
            // L can range from prev_idx + 1 to i.
            long left_count = (i - prev_idx); 

            // Calculate the number of valid right endpoints (R) for which 'num' at index 'i'
            // is part of the subarray [i, R].
            // R can range from i to N - 1.
            long right_count = (N - i);       

            // The contribution of num^2 for this specific 'num' at index 'i'
            // is sq_num * left_count * right_count.
            // All intermediate products are taken modulo MOD.
            long contribution = (sq_num * left_count) % MOD;
            contribution = (contribution * right_count) % MOD;

            // Add the contribution to the total sum, taking modulo MOD.
            totalSum = (totalSum + contribution) % MOD;

            // Update the last seen index for 'num'.
            lastSeen.put(num, i);
        }

        // The final total sum is returned as an int, as required by the method signature.
        return (int)totalSum;
    }
}