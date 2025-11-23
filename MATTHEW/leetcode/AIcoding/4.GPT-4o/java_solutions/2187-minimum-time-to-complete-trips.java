class Solution {
    public long minimumTime(int[] time, int totalTrips) {
        long left = 1, right = Long.MAX_VALUE;
        while (left < right) {
            long mid = left + (right - left) / 2;
            long trips = 0;
            for (int t : time) {
                trips += mid / t;
                if (trips >= totalTrips) break;
            }
            if (trips >= totalTrips) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }
}