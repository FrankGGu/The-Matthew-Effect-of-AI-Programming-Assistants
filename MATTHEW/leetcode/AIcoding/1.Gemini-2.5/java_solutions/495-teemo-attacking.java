class Solution {
    public int findPoisonedDuration(int[] timeSeries, int duration) {
        if (timeSeries == null || timeSeries.length == 0) {
            return 0;
        }

        long totalDuration = 0;
        for (int i = 0; i < timeSeries.length - 1; i++) {
            int currentAttackTime = timeSeries[i];
            int nextAttackTime = timeSeries[i + 1];

            totalDuration += Math.min(duration, nextAttackTime - currentAttackTime);
        }

        totalDuration += duration;

        return (int) totalDuration;
    }
}