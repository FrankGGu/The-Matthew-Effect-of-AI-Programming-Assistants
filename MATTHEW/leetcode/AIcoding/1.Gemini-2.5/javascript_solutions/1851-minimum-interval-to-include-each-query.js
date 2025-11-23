class MinHeap {
    constructor() {
        this.heap = [];
    }

    push(val) {
        this.heap.push(val);
        this._bubbleUp(this.heap.length - 1);
    }

    pop() {
        if (this.isEmpty()) return null;
        if (this.heap.length === 1) return this.heap.pop();

        const root = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._bubbleDown(0);
        return root;
    }

    peek() {
        return this.isEmpty() ? null : this.heap[0];
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    _bubbleUp(index) {
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[parentIndex][0] > this.heap[index][0]) {
                [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
                index = parentIndex;
            } else {
                break;
            }
        }
    }

    _bubbleDown(index) {
        const lastIndex = this.heap.length - 1;
        while (true) {
            let leftChildIndex = 2 * index + 1;
            let rightChildIndex = 2 * index + 2;
            let smallestIndex = index;

            if (leftChildIndex <= lastIndex && this.heap[leftChildIndex][0] < this.heap[smallestIndex][0]) {
                smallestIndex = leftChildIndex;
            }

            if (rightChildIndex <= lastIndex && this.heap[rightChildIndex][0] < this.heap[smallestIndex][0]) {
                smallestIndex = rightChildIndex;
            }

            if (smallestIndex !== index) {
                [this.heap[index], this.heap[smallestIndex]] = [this.heap[smallestIndex], this.heap[index]];
                index = smallestIndex;
            } else {
                break;
            }
        }
    }
}

var minInterval = function(intervals, queries) {
    const processedQueries = queries.map((q, i) => [q, i]);

    intervals.sort((a, b) => a[0] - b[0]);
    processedQueries.sort((a, b) => a[0] - b[0]);

    const results = new Array(queries.length).fill(-1);
    const minHeap = new MinHeap();

    let intervalPointer = 0;
    const n = intervals.length;

    for (const [queryValue, originalIndex] of processedQueries) {
        while (intervalPointer < n && intervals[intervalPointer][0] <= queryValue) {
            const [start, end] = intervals[intervalPointer];
            const length = end - start + 1;
            minHeap.push([length, end]);
            intervalPointer++;
        }

        while (!minHeap.isEmpty() && minHeap.peek()[1] < queryValue) {
            minHeap.pop();
        }

        if (!minHeap.isEmpty()) {
            results[originalIndex] = minHeap.peek()[0];
        }
    }

    return results;
};