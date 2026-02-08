class Solution {
    public int[] numMovesStonesII(int[] stones) {
        Arrays.sort(stones);
        int n = stones.length;
        int maxMoves = Math.max(stones[n - 1] - stones[1] - (n - 2), stones[n - 2] - stones[0] - (n - 2));
        int minMoves = Integer.MAX_VALUE;

        for (int i = 0; i < n; i++) {
            int left = stones[i] - i;
            int right = stones[i] + (n - 1 - i);
            if (left <= stones[0] && right >= stones[n - 1]) {
                minMoves = Math.min(minMoves, 0);
            } else if (i > 0 && left <= stones[0] && right < stones[n - 1]) {
                minMoves = Math.min(minMoves, 1);
            } else if (i < n - 1 && left > stones[0] && right >= stones[n - 1]) {
                minMoves = Math.min(minMoves, 1);
            } else {
                minMoves = Math.min(minMoves, 2);
            }
        }

        return new int[]{minMoves, maxMoves};
    }
}