class MinHeap {
    constructor() {
        this.heap = [];
    }

    push(val) {
        this.heap.push(val);
        this._bubbleUp(this.heap.length - 1);
    }

    pop() {
        if (this.isEmpty()) {
            return undefined;
        }
        if (this.heap.length === 1) {
            return this.heap.pop();
        }
        const min = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._bubbleDown(0);
        return min;
    }

    peek() {
        return this.heap[0];
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    _bubbleUp(index) {
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[parentIndex] > this.heap[index]) {
                this._swap(parentIndex, index);
                index = parentIndex;
            } else {
                break;
            }
        }
    }

    _bubbleDown(index) {
        const lastIndex = this.heap.length - 1;
        while (true) {
            const leftChildIndex = 2 * index + 1;
            const rightChildIndex = 2 * index + 2;
            let smallestIndex = index;

            if (leftChildIndex <= lastIndex && this.heap[leftChildIndex] < this.heap[smallestIndex]) {
                smallestIndex = leftChildIndex;
            }
            if (rightChildIndex <= lastIndex && this.heap[rightChildIndex] < this.heap[smallestIndex]) {
                smallestIndex = rightChildIndex;
            }

            if (smallestIndex !== index) {
                this._swap(index, smallestIndex);
                index = smallestIndex;
            } else {
                break;
            }
        }
    }

    _swap(i, j) {
        [this.heap[i], this.heap[j]] = [this.heap[j], this.heap[i]];
    }
}

var smallestUnoccupiedChair = function(times, targetFriend) {
    const n = times.length;
    const events = [];

    for (let i = 0; i < n; i++) {
        const [arrivalTime, departureTime] = times[i];
        // Event format: [time, type, friendId]
        // type 0 for arrival, 1 for departure
        events.push([arrivalTime, 0, i]);
        events.push([departureTime, 1, i]);
    }

    events.sort((a, b) => {
        if (a[0] !== b[0]) {
            return a[0] - b[0];
        }
        return b[1] - a[1];
    });

    const occupiedChairs = new Map();
    const availableChairs = new MinHeap();

    for (let i = 0; i < n; i++) {
        availableChairs.push(i);
    }

    for (const [time, type, friendId] of events) {
        if (type === 1) { // Departure
            const chairId = occupiedChairs.get(friendId);
            occupiedChairs.delete(friendId);
            availableChairs.push(chairId);
        } else { // Arrival
            const chairId = availableChairs.pop();
            occupiedChairs.set(friendId, chairId);
            if (friendId === targetFriend) {
                return chairId;
            }
        }
    }
};