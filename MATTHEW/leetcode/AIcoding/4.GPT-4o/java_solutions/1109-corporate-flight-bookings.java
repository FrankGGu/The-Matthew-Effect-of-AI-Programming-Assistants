class Solution {
    public int[] corpFlightBookings(int[][] bookings, int n) {
        int[] result = new int[n];
        int[] delta = new int[n + 1];

        for (int[] booking : bookings) {
            int start = booking[0];
            int end = booking[1];
            int seats = booking[2];
            delta[start - 1] += seats;
            delta[end] -= seats;
        }

        for (int i = 0; i < n; i++) {
            if (i > 0) {
                delta[i] += delta[i - 1];
            }
            result[i] = delta[i];
        }

        return result;
    }
}