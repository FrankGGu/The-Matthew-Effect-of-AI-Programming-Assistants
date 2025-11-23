import java.util.Arrays;

class Solution {
    public int[] numMovesStones(int a, int b, int c) {
        int[] stones = {a, b, c};
        Arrays.sort(stones);
        int x = stones[0];
        int y = stones[1];
        int z = stones[2];

        int minMoves;
        int maxMoves;

        // Calculate minMoves
        if (y - x == 1 && z - y == 1) {
            minMoves = 0;
        } else if (y - x <= 2 || z - y <= 2) {
            minMoves = 1;
        } else {
            minMoves = 2;
        }

        // Calculate maxMoves
        maxMoves = (y - x - 1) + (z - y - 1);

        return new int[]{minMoves, maxMoves};
    }
}