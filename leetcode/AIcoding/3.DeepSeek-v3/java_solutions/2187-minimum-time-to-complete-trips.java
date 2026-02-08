class Solution {
    public long minimumTime(int[] time, int totalTrips) {
        long left = 1;
        long right = (long) Arrays.stream(time).min().getAsInt() * totalTrips;

        while (left < right) {
            long mid = left + (right - left) / 2;
            long trips = 0;
            for (int t : time) {
                trips += mid / t;
            }
            if (trips < totalTrips) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        return left;
    }
}