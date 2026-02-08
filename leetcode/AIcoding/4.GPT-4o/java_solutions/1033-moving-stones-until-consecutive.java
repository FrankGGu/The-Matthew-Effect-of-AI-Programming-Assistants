import java.util.Arrays;

class Solution {
    public int[] numMovesStones(int a, int b, int c) {
        int[] stones = {a, b, c};
        Arrays.sort(stones);
        int minMove = 0, maxMove = stones[2] - stones[0] - 2;

        if (stones[0] + 1 == stones[1] && stones[1] + 1 == stones[2]) {
            minMove = 0;
        } else if (stones[0] + 1 == stones[1] || stones[1] + 1 == stones[2]) {
            minMove = 1;
        } else if (stones[0] + 2 == stones[1] || stones[1] + 2 == stones[2]) {
            minMove = 1;
        } else {
            minMove = 2;
        }

        return new int[] {minMove, maxMove};
    }
}