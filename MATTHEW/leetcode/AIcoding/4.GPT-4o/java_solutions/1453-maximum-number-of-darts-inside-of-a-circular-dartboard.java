import java.util.Arrays;

public class Solution {
    public int numDartsInArea(int[][] darts, int r) {
        int maxDarts = 0;
        for (int[] dart : darts) {
            int count = 0;
            for (int[] otherDart : darts) {
                if (Math.pow(dart[0] - otherDart[0], 2) + Math.pow(dart[1] - otherDart[1], 2) <= r * r) {
                    count++;
                }
            }
            maxDarts = Math.max(maxDarts, count);
        }
        return maxDarts;
    }
}