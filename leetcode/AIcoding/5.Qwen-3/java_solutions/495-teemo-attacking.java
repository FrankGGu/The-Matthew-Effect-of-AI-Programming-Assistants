public class Solution {
    public int findPoisonedDuration(int[] timeSeries, int duration) {
        if (timeSeries == null || timeSeries.length == 0 || duration == 0) {
            return 0;
        }
        int total = 0;
        for (int i = 1; i < timeSeries.length; i++) {
            total += Math.min(timeSeries[i] - timeSeries[i - 1], duration);
        }
        total += duration;
        return total;
    }
}