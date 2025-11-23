import java.util.Arrays;

class Solution {
    public int minMoves(int[] nums, int limit) {
        int n = nums.length;
        // diff array to store changes in moves.
        // Index represents the target sum S.
        // Max possible sum for x+y where 1 <= x,y <= limit is 2*limit.
        // Min possible sum is 1+1=2.
        // We need indices up to 2*limit + 1 for the sweep line to correctly handle the end boundary.
        int[] diff = new int[2 * limit + 2];

        // Initial state: all n/2 pairs require 2 moves.
        // So, the base number of moves for any sum S is n (n/2 pairs * 2 moves/pair).

        for (int i = 0; i < n / 2; i++) {
            int a = nums[i];
            int b = nums[n - 1 - i];

            int minVal = Math.min(a, b);
            int maxVal = Math.max(a, b);

            // For any pair (a, b), the maximum possible sum is limit + limit, and minimum is 1 + 1.
            //
            // 1. If we need to change both 'a' and 'b' to achieve sum S:
            //    This happens if S is outside the range [1 + min(a,b), limit + max(a,b)].
            //    For these sums, the pair contributes 2 moves.
            //
            // 2. If we need to change only one of 'a' or 'b' to achieve sum S:
            //    This happens if S is within the range [1 + min(a,b), limit + max(a,b)]
            //    but S is not equal to a + b.
            //    For these sums, the pair contributes 1 move.
            //
            // 3. If we don't need to change anything (0 moves):
            //    This happens if S == a + b.
            //    For this specific sum, the pair contributes 0 moves.

            // The strategy is to assume all pairs initially cost 2 moves.
            // Then, for ranges where the cost is less, we subtract from the running total.

            // Range [1 + minVal, limit + maxVal]: cost reduces by 1 (from 2 to 1).
            // This means that starting from sum (1 + minVal), the cost for this pair decreases by 1.
            // It reverts back to 2 moves when the sum exceeds (limit + maxVal).
            diff[1 + minVal]--;
            diff[limit + maxVal + 1]++;

            // Specific sum a + b: cost reduces by another 1 (from 1 to 0).
            // This means that at sum (a + b), the cost for this pair decreases by another 1.
            // It reverts back to 1 move when the sum exceeds (a + b).
            diff[a + b]--;
            diff[a + b + 1]++;
        }

        int currentMoves = n; // Initial moves if all pairs need 2 changes (n/2 pairs * 2 moves).
        int minTotalMoves = n;

        // Iterate through all possible target sums S from 2 to 2*limit.
        // The minimum possible sum is 1+1=2. The maximum is limit+limit=2*limit.
        for (int s = 2; s <= 2 * limit; s++) {
            currentMoves += diff[s]; // Apply changes for sum 's'
            minTotalMoves = Math.min(minTotalMoves, currentMoves);
        }

        return minTotalMoves;
    }
}