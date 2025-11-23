import java.util.Arrays;

class Solution {
    public int earliestBloom(int[][] flowers) {
        Arrays.sort(flowers, (a, b) -> a[1] - b[1]);
        int day = 0;
        for (int[] flower : flowers) {
            day = Math.max(day, flower[0]) + 1;
        }
        return day;
    }
}