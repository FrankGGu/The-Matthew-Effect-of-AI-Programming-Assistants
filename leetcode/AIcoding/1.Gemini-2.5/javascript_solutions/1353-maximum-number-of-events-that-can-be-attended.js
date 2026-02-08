class MinHeap {
    constructor() {
        this.heap = [];
    }

    getParentIndex(i) {
        return Math.floor((i - 1) / 2);
    }

    getLeftChildIndex(i) {
        return 2 * i + 1;
    }

    getRightChildIndex(i) {
        return 2 * i + 2;
    }

    hasParent(i) {
        return this.getParentIndex(i) >= 0;
    }

    hasLeftChild(i) {
        return this.getLeftChildIndex(i) < this.heap.length;
    }

    hasRightChild(i) {
        return this.getRightChildIndex(i) < this.heap.length;
    }

    getParent(i) {
        return this.heap[this.getParentIndex(i)];
    }

    getLeftChild(i) {
        return this.heap[this.getLeftChildIndex(i)];
    }

    getRightChild(i) {
        return this.heap[this.getRightChildIndex(i)];
    }

    swap(i, j) {
        [this.heap[i], this.heap[j]] = [this.heap[j], this.heap[i]];
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    peek() {
        if (this.isEmpty()) {
            return null;
        }
        return this.heap[0];
    }

    push(item) {
        this.heap.push(item);
        this.heapifyUp();
    }

    pop() {
        if (this.isEmpty()) {
            return null;
        }
        if (this.heap.length === 1) {
            return this.heap.pop();
        }
        const item = this.heap[0];
        this.heap[0] = this.heap.pop();
        this.heapifyDown();
        return item;
    }

    heapifyUp() {
        let index = this.heap.length - 1;
        while (this.hasParent(index) && this.getParent(index) > this.heap[index]) {
            this.swap(this.getParentIndex(index), index);
            index = this.getParentIndex(index);
        }
    }

    heapifyDown() {
        let index = 0;
        while (this.hasLeftChild(index)) {
            let smallerChildIndex = this.getLeftChildIndex(index);
            if (this.hasRightChild(index) && this.getRightChild(index) < this.getLeftChild(index)) {
                smallerChildIndex = this.getRightChildIndex(index);
            }

            if (this.heap[index] < this.heap[smallerChildIndex]) {
                break;
            } else {
                this.swap(index, smallerChildIndex);
            }
            index = smallerChildIndex;
        }
    }
}

var maxEvents = function(events) {
    events.sort((a, b) => a[0] - b[0]);

    let maxDay = 0;
    for (const [start, end] of events) {
        maxDay = Math.max(maxDay, end);
    }

    const minHeap = new MinHeap();
    let attendedCount = 0;
    let eventPointer = 0;

    for (let day = 1; day <= maxDay; day++) {
        while (eventPointer < events.length && events[eventPointer][0] === day) {
            minHeap.push(events[eventPointer][1]);
            eventPointer++;
        }

        while (!minHeap.isEmpty() && minHeap.peek() < day) {
            minHeap.pop();
        }

        if (!minHeap.isEmpty()) {
            minHeap.pop();
            attendedCount++;
        }
    }

    return attendedCount;
};