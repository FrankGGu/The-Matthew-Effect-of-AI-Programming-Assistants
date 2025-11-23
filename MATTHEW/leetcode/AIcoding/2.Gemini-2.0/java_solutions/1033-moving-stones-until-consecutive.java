import java.util.Arrays;

class Solution {
    public int[] numMovesStones(int a, int b, int c) {
        int[] stones = {a, b, c};
        Arrays.sort(stones);
        int min = 0;
        int max = stones[2] - stones[0] - 2;
        if (stones[1] - stones[0] <= 2 || stones[2] - stones[1] <= 2) {
            if (stones[1] - stones[0] <= 1 || stones[2] - stones[1] <= 1) {
                min = 0;
            } else {
                min = 1;
            }
        } else {
            min = 2;
        }
        return new int[]{min, max};
    }
}