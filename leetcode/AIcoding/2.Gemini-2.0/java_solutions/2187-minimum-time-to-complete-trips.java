class Solution {
    public long minimumTime(int[] time, int totalTrips) {
        long left = 1;
        long right = 100000000000000L;
        long ans = right;

        while (left <= right) {
            long mid = left + (right - left) / 2;
            long trips = 0;
            for (int t : time) {
                trips += mid / t;
            }

            if (trips >= totalTrips) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        return ans;
    }
}