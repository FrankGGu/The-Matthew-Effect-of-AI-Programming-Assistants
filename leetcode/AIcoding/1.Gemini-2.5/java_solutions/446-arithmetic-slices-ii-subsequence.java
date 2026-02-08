import java.util.HashMap;
import java.util.Map;

class Solution {
    public int numberOfArithmeticSlices(int[] nums) {
        int n = nums.length;
        if (n < 3) {
            return 0;
        }

        // dp[i] is a map where:
        // - key: the common difference (long)
        // - value: the count of arithmetic subsequences of length >= 2
        //          ending at index i with that common difference (long)
        Map<Long, Long>[] dp = new Map[n];
        long totalArithmeticSlices = 0;

        for (int i = 0; i < n; i++) {
            dp[i] = new HashMap<>();
            for (int j = 0; j < i; j++) {
                long diff = (long) nums[i] - nums[j];

                // Get the count of arithmetic subsequences of length >= 2
                // ending at index j with the current 'diff'.
                // These subsequences, when extended by nums[i], become length >= 3
                // and thus contribute to the total count of arithmetic slices.
                long countJDiff = dp[j].getOrDefault(diff, 0L);

                // Get the current count of arithmetic subsequences of length >= 2
                // ending at index i with the current 'diff'.
                long currentPairsAtI = dp[i].getOrDefault(diff, 0L);

                // Add the subsequences of length >= 3 formed by extending those ending at j.
                // Each 'countJDiff' subsequence ending at 'j' can be extended by 'nums[i]'
                // to form a new arithmetic subsequence of length at least 3.
                totalArithmeticSlices += countJDiff;

                // Update dp[i] for the current difference.
                // The new count includes:
                // 1. All subsequences counted in 'countJDiff', which are now extended to nums[i].
                // 2. The new pair (nums[j], nums[i]) itself, which forms a length 2 subsequence.
                dp[i].put(diff, currentPairsAtI + countJDiff + 1L);
            }
        }

        // The problem guarantees the answer fits in a 32-bit signed integer.
        return (int) totalArithmeticSlices;
    }
}