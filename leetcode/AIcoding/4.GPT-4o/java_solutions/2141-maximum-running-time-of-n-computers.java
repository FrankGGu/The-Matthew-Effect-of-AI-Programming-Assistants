import java.util.Arrays;

public class Solution {
    public long maxRunTime(int n, int[] batteries) {
        long left = 1, right = (long) 1e14;
        while (left < right) {
            long mid = left + (right - left + 1) / 2;
            if (canRun(n, batteries, mid)) {
                left = mid;
            } else {
                right = mid - 1;
            }
        }
        return left;
    }

    private boolean canRun(int n, int[] batteries, long time) {
        long totalPower = 0;
        for (int battery : batteries) {
            totalPower += Math.min(battery, time);
        }
        return totalPower >= time * n;
    }
}