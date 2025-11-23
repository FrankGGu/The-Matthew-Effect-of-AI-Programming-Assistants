class Solution {
    public int[] corpFlightBookings(int[][] bookings, int n) {
        int[] result = new int[n];

        for (int[] booking : bookings) {
            int firstFlight = booking[0] - 1;
            int lastFlight = booking[1] - 1;
            int seats = booking[2];

            result[firstFlight] += seats;
            if (lastFlight + 1 < n) {
                result[lastFlight + 1] -= seats;
            }
        }

        for (int i = 1; i < n; i++) {
            result[i] += result[i - 1];
        }

        return result;
    }
}