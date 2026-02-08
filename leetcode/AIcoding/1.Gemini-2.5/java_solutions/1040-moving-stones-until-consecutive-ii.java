import java.util.Arrays;

class Solution {
    public int[] numMovesStonesII(int[] stones) {
        Arrays.sort(stones);
        int n = stones.length;

        // Calculate maximum moves
        // The maximum number of moves is the total number of empty spaces if we fill the range [s[0], s[n-1]]
        // minus the minimum of the two "end gaps".
        // The total empty spaces in the range [s[0], s[n-1]] is (stones[n-1] - stones[0] + 1) - n.
        // The left end gap is stones[1] - stones[0] - 1.
        // The right end gap is stones[n-1] - stones[n-2] - 1.
        // To maximize moves, we want to leave the largest possible gap at one of the ends unfilled.
        // So we fill the smaller of the two end gaps.
        // The number of moves is (total empty spaces) - (smaller end gap).
        int maxMoves = (stones[n - 1] - stones[0] + 1) - n;
        maxMoves -= Math.min(stones[1] - stones[0] - 1, stones[n - 1] - stones[n - 2] - 1);

        // Calculate minimum moves
        // Use a sliding window to find the maximum number of stones that can be in a consecutive block of length n.
        // The number of moves is n - (max stones in a window).
        // Special case: if n-1 stones are consecutive, and the remaining stone is "far away" from this block.
        // "Far away" means the gap is > 1.
        // The problem states "move it to an unoccupied position so that it is no longer an endpoint stone".
        // This implies that the moved stone's new position must be strictly between two other existing stones.
        // If n-1 stones are consecutive, and the remaining stone is far away (gap > 1) from the block,
        // moving it to complete the block would make it an endpoint, which is an invalid move.
        // In this specific scenario, 2 moves are required instead of 1.
        int minMoves = n;
        int i = 0;
        for (int j = 0; j < n; j++) {
            while (stones[j] - stones[i] + 1 > n) {
                i++;
            }
            int count = j - i + 1; // Number of stones in current window [stones[i], ..., stones[j]]

            // Check for the special case:
            // If we need to move exactly one stone (n - count == 1)
            // AND the n-1 stones in the current window are consecutive (stones[j] - stones[i] == n - 2)
            // AND the remaining stone (which is either stones[0] or stones[n-1]) is "far away" (gap > 1)
            // from the consecutive block.
            // "Far away" means:
            //   If stones[i] is not stones[0] (meaning stones[0] is the remaining stone)
            //   AND stones[i] - stones[0] > 1 (gap between stones[0] and stones[i] is > 1)
            // OR
            //   If stones[j] is not stones[n-1] (meaning stones[n-1] is the remaining stone)
            //   AND stones[n-1] - stones[j] > 1 (gap between stones[j] and stones[n-1] is > 1)
            if (n - count == 1 && stones[j] - stones[i] == n - 2 &&
                ((stones[i] > stones[0] && stones[i] - stones[0] > 1) ||
                 (stones[j] < stones[n - 1] && stones[n - 1] - stones[j] > 1))) {
                minMoves = Math.min(minMoves, 2);
            } else {
                minMoves = Math.min(minMoves, n - count);
            }
        }

        return new int[]{minMoves, maxMoves};
    }
}