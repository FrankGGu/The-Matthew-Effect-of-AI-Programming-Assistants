class MaxHeap {
    constructor() {
        this.heap = [];
    }

    push(val) {
        this.heap.push(val);
        this._bubbleUp(this.heap.length - 1);
    }

    pop() {
        if (this.isEmpty()) {
            return null;
        }
        if (this.heap.length === 1) {
            return this.heap.pop();
        }
        const max = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._sinkDown(0);
        return max;
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
            if (this.heap[parentIndex] < this.heap[index]) {
                [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
                index = parentIndex;
            } else {
                break;
            }
        }
    }

    _sinkDown(index) {
        const lastIndex = this.heap.length - 1;
        while (true) {
            let largestIndex = index;
            const leftChildIndex = 2 * index + 1;
            const rightChildIndex = 2 * index + 2;

            if (leftChildIndex <= lastIndex && this.heap[leftChildIndex] > this.heap[largestIndex]) {
                largestIndex = leftChildIndex;
            }

            if (rightChildIndex <= lastIndex && this.heap[rightChildIndex] > this.heap[largestIndex]) {
                largestIndex = rightChildIndex;
            }

            if (largestIndex !== index) {
                [this.heap[index], this.heap[largestIndex]] = [this.heap[largestIndex], this.heap[index]];
                index = largestIndex;
            } else {
                break;
            }
        }
    }
}

var inventoryManagement = function(stock, k) {
    const maxHeap = new MaxHeap();
    for (const item of stock) {
        maxHeap.push(item);
    }

    let totalProfit = 0;
    const MOD = 1000000007;

    for (let i = 0; i < k; i++) {
        if (maxHeap.isEmpty()) {
            break;
        }
        let currentMax = maxHeap.pop();
        totalProfit = (totalProfit + currentMax) % MOD;
        if (currentMax - 1 > 0) {
            maxHeap.push(currentMax - 1);
        }
    }

    return totalProfit;
};