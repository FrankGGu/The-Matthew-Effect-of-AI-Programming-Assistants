function maximumProduct(nums, k) {
    const MOD = 10 ** 9 + 7;
    const minHeap = new MinHeap();
    for (const num of nums) {
        minHeap.push(num);
    }
    for (let i = 0; i < k; i++) {
        let smallest = minHeap.pop();
        minHeap.push(smallest + 1);
    }
    let result = 1;
    while (!minHeap.isEmpty()) {
        result = (result * minHeap.pop()) % MOD;
    }
    return result;
}

class MinHeap {
    constructor() {
        this.heap = [];
    }

    push(value) {
        this.heap.push(value);
        this.bubbleUp(this.heap.length - 1);
    }

    pop() {
        if (this.heap.length === 0) return null;
        if (this.heap.length === 1) return this.heap.pop();
        const root = this.heap[0];
        this.heap[0] = this.heap.pop();
        this.bubbleDown(0);
        return root;
    }

    isEmpty() {
        return this.heap.length === 0;
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
        let leftChildIdx = 2 * index + 1;
        let rightChildIdx = 2 * index + 2;

        let swapIdx = null;

        if (leftChildIdx < length) {
            if (this.heap[leftChildIdx] < element) {
                swapIdx = leftChildIdx;
            }
        }

        if (rightChildIdx < length) {
            if (
                (swapIdx === null && this.heap[rightChildIdx] < element) ||
                (swapIdx !== null && this.heap[rightChildIdx] < this.heap[swapIdx])
            ) {
                swapIdx = rightChildIdx;
            }
        }

        if (swapIdx !== null) {
            [this.heap[index], this.heap[swapIdx]] = [this.heap[swapIdx], this.heap[index]];
            index = swapIdx;
            this.bubbleDown(index);
        }
    }
}