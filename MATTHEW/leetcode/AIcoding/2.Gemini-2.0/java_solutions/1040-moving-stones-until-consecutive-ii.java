import java.util.Arrays;

class Solution {
    public int[] numMovesStonesII(int[] stones) {
        Arrays.sort(stones);
        int n = stones.length;
        int maxMoves = Math.max(stones[n - 1] - stones[1] - n + 2, stones[n - 2] - stones[0] - n + 2);
        int minMoves = Integer.MAX_VALUE;
        int j = 0;
        for (int i = 0; i < n; i++) {
            while (stones[j] - stones[i] + 1 <= n) {
                j++;
                if (j == n) break;
            }
            int count = j - i;
            if (count == n - 1 && stones[j - 1] - stones[i] + 1 == n - 1) {
                minMoves = Math.min(minMoves, 2);
            } else {
                minMoves = Math.min(minMoves, n - count);
            }
        }
        return new int[]{minMoves, maxMoves};
    }
}