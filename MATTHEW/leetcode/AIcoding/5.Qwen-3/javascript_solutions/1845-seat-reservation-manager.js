class SeatManager {
    constructor(n) {
        this.heap = new MinHeap();
        for (let i = 1; i <= n; i++) {
            this.heap.insert(i);
        }
    }

    reserve() {
        return this.heap.extractMin();
    }

    unreserve(seatNumber) {
        this.heap.insert(seatNumber);
    }
}

class MinHeap {
    constructor() {
        this.heap = [];
    }

    insert(value) {
        this.heap.push(value);
        this.bubbleUp(this.heap.length - 1);
    }

    extractMin() {
        if (this.heap.length === 0) return null;
        if (this.heap.length === 1) return this.heap.pop();

        const min = this.heap[0];
        this.heap[0] = this.heap.pop();
        this.bubbleDown(0);
        return min;
    }

    bubbleUp(index) {
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[parentIndex] <= this.heap[index]) break;
            [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
            index = parentIndex;
        }
    }

    bubbleDown(index) {
        const length = this.heap.length;
        const element = this.heap[index];

        while (true) {
            let leftChildIndex = 2 * index + 1;
            let rightChildIndex = 2 * index + 2;

            let swapIndex = null;

            if (leftChildIndex < length && this.heap[leftChildIndex] < element) {
                swapIndex = leftChildIndex;
            }

            if (rightChildIndex < length) {
                if (
                    swapIndex === null &&
                    this.heap[rightChildIndex] < element
                ) {
                    swapIndex = rightChildIndex;
                } else if (
                    swapIndex !== null &&
                    this.heap[rightChildIndex] < this.heap[swapIndex]
                ) {
                    swapIndex = rightChildIndex;
                }
            }

            if (swapIndex === null) break;

            [this.heap[index], this.heap[swapIndex]] = [this.heap[swapIndex], this.heap[index]];
            index = swapIndex;
        }
    }
}