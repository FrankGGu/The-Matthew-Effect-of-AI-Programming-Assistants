public class Solution {

import java.util.PriorityQueue;

public class SeatReservationManager {
    private PriorityQueue<Integer> availableSeats;

    public SeatReservationManager(int n) {
        availableSeats = new PriorityQueue<>();
        for (int i = 1; i <= n; i++) {
            availableSeats.add(i);
        }
    }

    public int reserve() {
        return availableSeats.poll();
    }

    public void unreserve(int seatNumber) {
        availableSeats.add(seatNumber);
    }
}
}