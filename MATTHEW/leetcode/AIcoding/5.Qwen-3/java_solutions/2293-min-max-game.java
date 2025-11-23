public class Solution {
    public int findMinDifference(String[] timePoints) {
        int n = timePoints.length;
        int[] times = new int[n];
        for (int i = 0; i < n; i++) {
            String[] parts = timePoints[i].split(":");
            int hours = Integer.parseInt(parts[0]);
            int minutes = Integer.parseInt(parts[1]);
            times[i] = hours * 60 + minutes;
        }
        java.util.Arrays.sort(times);
        int minDiff = Integer.MAX_VALUE;
        for (int i = 0; i < n; i++) {
            int diff = times[(i + 1) % n] - times[i];
            if (diff > 720) {
                diff -= 1440;
            }
            minDiff = Math.min(minDiff, diff);
        }
        return minDiff;
    }
}