class MinPriorityQueue {
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
        this._sinkDown(0);
        return min;
    }

    peek() {
        return this.heap[0];
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    size() {
        return this.heap.length;
    }

    _bubbleUp(idx) {
        let parentIdx = Math.floor((idx - 1) / 2);
        while (idx > 0 && this.heap[idx] < this.heap[parentIdx]) {
            [this.heap[idx], this.heap[parentIdx]] = [this.heap[parentIdx], this.heap[idx]];
            idx = parentIdx;
            parentIdx = Math.floor((idx - 1) / 2);
        }
    }

    _sinkDown(idx) {
        const len = this.heap.length;
        const element = this.heap[idx];
        while (true) {
            let leftChildIdx = 2 * idx + 1;
            let rightChildIdx = 2 * idx + 2;
            let leftChild, rightChild;
            let swap = null;

            if (leftChildIdx < len) {
                leftChild = this.heap[leftChildIdx];
                if (leftChild < element) {
                    swap = leftChildIdx;
                }
            }

            if (rightChildIdx < len) {
                rightChild = this.heap[rightChildIdx];
                if (
                    (swap === null && rightChild < element) ||
                    (swap !== null && rightChild < leftChild)
                ) {
                    swap = rightChildIdx;
                }
            }

            if (swap === null) break;
            [this.heap[idx], this.heap[swap]] = [this.heap[swap], this.heap[idx]];
            idx = swap;
        }
    }
}

var maxPerformance = function(n_val, speeds, efficiencies, k) {
    const engineers = [];
    for (let i = 0; i < n_val; i++) {
        engineers.push([efficiencies[i], speeds[i]]);
    }

    engineers.sort((a, b) => b[0] - a[0]);

    let maxPerformance = 0;
    let currentSpeedSum = 0;
    const minHeap = new MinPriorityQueue();

    for (const [efficiency, speed] of engineers) {
        currentSpeedSum += speed;
        minHeap.push(speed);

        if (minHeap.size() > k) {
            currentSpeedSum -= minHeap.pop();
        }

        maxPerformance = Math.max(maxPerformance, currentSpeedSum * efficiency);
    }

    return maxPerformance;
};