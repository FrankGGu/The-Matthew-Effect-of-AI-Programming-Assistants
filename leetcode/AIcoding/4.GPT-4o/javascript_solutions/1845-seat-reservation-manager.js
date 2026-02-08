class SeatManager {
    constructor(n) {
        this.availableSeats = new MinPriorityQueue();
        for (let i = 1; i <= n; i++) {
            this.availableSeats.enqueue(i);
        }
    }

    reserve() {
        return this.availableSeats.dequeue().element;
    }

    unreserve(seatNumber) {
        this.availableSeats.enqueue(seatNumber);
    }
}