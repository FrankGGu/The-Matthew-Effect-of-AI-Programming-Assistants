public class Solution {
    public int maxScoreSightseeing(int[] values) {
        int max = 0;
        int prev = values[0];
        for (int i = 1; i < values.length; i++) {
            max = Math.max(max, prev + values[i] - 1);
            prev = Math.max(prev, values[i] - 1);
        }
        return max;
    }
}