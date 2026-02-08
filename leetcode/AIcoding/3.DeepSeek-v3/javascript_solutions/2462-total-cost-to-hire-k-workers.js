var totalCost = function(costs, k, candidates) {
    const leftHeap = new MinHeap();
    const rightHeap = new MinHeap();
    let left = 0;
    let right = costs.length - 1;
    let total = 0;

    for (let i = 0; i < k; i++) {
        while (leftHeap.size() < candidates && left <= right) {
            leftHeap.insert(costs[left]);
            left++;
        }
        while (rightHeap.size() < candidates && left <= right) {
            rightHeap.insert(costs[right]);
            right--;
        }

        const leftMin = leftHeap.size() > 0 ? leftHeap.peek() : Infinity;
        const rightMin = rightHeap.size() > 0 ? rightHeap.peek() : Infinity;

        if (leftMin <= rightMin) {
            total += leftHeap.extractMin();
        } else {
            total += rightHeap.extractMin();
        }
    }

    return total;
};

class MinHeap {
    constructor() {
        this.heap = [];
    }

    size() {
        return this.heap.length;
    }

    insert(val) {
        this.heap.push(val);
        this.bubbleUp(this.heap.length - 1);
    }

    bubbleUp(index) {
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[parentIndex] > this.heap[index]) {
                [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
                index = parentIndex;
            } else {
                break;
            }
        }
    }

    extractMin() {
        if (this.heap.length === 0) return null;
        const min = this.heap[0];
        const last = this.heap.pop();
        if (this.heap.length > 0) {
            this.heap[0] = last;
            this.sinkDown(0);
        }
        return min;
    }

    sinkDown(index) {
        const left = 2 * index + 1;
        const right = 2 * index + 2;
        let smallest = index;

        if (left < this.heap.length && this.heap[left] < this.heap[smallest]) {
            smallest = left;
        }
        if (right < this.heap.length && this.heap[right] < this.heap[smallest]) {
            smallest = right;
        }

        if (smallest !== index) {
            [this.heap[index], this.heap[smallest]] = [this.heap[smallest], this.heap[index]];
            this.sinkDown(smallest);
        }
    }

    peek() {
        return this.heap[0] || null;
    }
}