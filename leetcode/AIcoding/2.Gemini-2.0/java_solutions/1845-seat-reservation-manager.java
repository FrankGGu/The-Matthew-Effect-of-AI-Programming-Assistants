import java.util.PriorityQueue;

class SeatManager {

    private PriorityQueue<Integer> availableSeats;
    private int nextSeat;

    public SeatManager(int n) {
        availableSeats = new PriorityQueue<>();
        nextSeat = 1;
    }

    public int reserve() {
        if (!availableSeats.isEmpty()) {
            return availableSeats.poll();
        } else {
            return nextSeat++;
        }
    }

    public void unreserve(int seatNumber) {
        availableSeats.offer(seatNumber);
    }
}