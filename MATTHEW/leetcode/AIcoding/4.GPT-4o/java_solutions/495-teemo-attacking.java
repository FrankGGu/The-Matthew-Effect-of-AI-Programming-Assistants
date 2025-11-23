class Solution {
    public int findPoisonedDuration(int[] timeSeries, int duration) {
        int total = 0;
        for (int i = 1; i < timeSeries.length; i++) {
            total += Math.min(timeSeries[i] - timeSeries[i - 1], duration);
        }
        return total + duration;
    }
}