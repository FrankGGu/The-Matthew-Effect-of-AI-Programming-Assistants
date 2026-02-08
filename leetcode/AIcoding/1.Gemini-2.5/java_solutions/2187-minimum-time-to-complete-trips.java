import java.util.Arrays;

class Solution {
    public long minimumTime(int[] time, int totalTrips) {
        long low = 1;
        long maxTripDuration = 0;
        for (int t : time) {
            if (t > maxTripDuration) {
                maxTripDuration = t;
            }
        }
        long high = maxTripDuration * totalTrips;
        long ans = high;

        while (low <= high) {
            long mid = low + (high - low) / 2;
            if (canComplete(time, totalTrips, mid)) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return ans;
    }

    private boolean canComplete(int[] time, int totalTrips, long currentTime) {
        long tripsCompleted = 0;
        for (int t : time) {
            tripsCompleted += currentTime / t;
            if (tripsCompleted >= totalTrips) {
                return true;
            }
        }
        return tripsCompleted >= totalTrips;
    }
}