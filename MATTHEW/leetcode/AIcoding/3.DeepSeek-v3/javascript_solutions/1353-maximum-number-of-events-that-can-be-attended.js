var maxEvents = function(events) {
    events.sort((a, b) => a[0] - b[0]);
    let minHeap = new MinHeap();
    let i = 0, res = 0, n = events.length;
    for (let day = 1; day <= 100000; day++) {
        while (i < n && events[i][0] === day) {
            minHeap.insert(events[i][1]);
            i++;
        }
        while (minHeap.size() > 0 && minHeap.peek() < day) {
            minHeap.extractMin();
        }
        if (minHeap.size() > 0) {
            minHeap.extractMin();
            res++;
        }
    }
    return res;
};

class MinHeap {
    constructor() {
        this.heap = [];
    }

    size() {
        return this.heap.length;
    }

    peek() {
        return this.heap[0];
    }

    insert(val) {
        this.heap.push(val);
        this.bubbleUp(this.heap.length - 1);
    }

    extractMin() {
        const min = this.heap[0];
        const end = this.heap.pop();
        if (this.heap.length > 0) {
            this.heap[0] = end;
            this.sinkDown(0);
        }
        return min;
    }

    bubbleUp(idx) {
        const element = this.heap[idx];
        while (idx > 0) {
            const parentIdx = Math.floor((idx - 1) / 2);
            const parent = this.heap[parentIdx];
            if (element >= parent) break;
            this.heap[idx] = parent;
            this.heap[parentIdx] = element;
            idx = parentIdx;
        }
    }

    sinkDown(idx) {
        const left = 2 * idx + 1;
        const right = 2 * idx + 2;
        let smallest = idx;
        const length = this.heap.length;

        if (left < length && this.heap[left] < this.heap[smallest]) {
            smallest = left;
        }
        if (right < length && this.heap[right] < this.heap[smallest]) {
            smallest = right;
        }
        if (smallest !== idx) {
            [this.heap[idx], this.heap[smallest]] = [this.heap[smallest], this.heap[idx]];
            this.sinkDown(smallest);
        }
    }
}