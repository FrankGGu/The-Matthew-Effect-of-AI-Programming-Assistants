class SeatManager {
    constructor(n) {
        this.minHeap = new MinPriorityQueue();
        for (let i = 1; i <= n; i++) {
            this.minHeap.enqueue(i);
        }
    }

    reserve() {
        return this.minHeap.dequeue().element;
    }

    unreserve(seatNumber) {
        this.minHeap.enqueue(seatNumber);
    }
}