function minSumSquareDifference(nums, k) {
    let maxHeap = new MaxHeap();
    for (let num of nums) {
        maxHeap.push(num);
    }

    for (let i = 0; i < k.length; i++) {
        let current = maxHeap.pop();
        let decrease = Math.min(k[i], current);
        maxHeap.push(current - decrease);
    }

    let sum = 0;
    while (!maxHeap.isEmpty()) {
        let num = maxHeap.pop();
        sum += num * num;
    }
    return sum;
}

class MaxHeap {
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

        let root = this.heap[0];
        this.heap[0] = this.heap.pop();
        this.bubbleDown(0);
        return root;
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    bubbleUp(index) {
        while (index > 0) {
            let parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[parentIndex] >= this.heap[index]) break;
            [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
            index = parentIndex;
        }
    }

    bubbleDown(index) {
        let lastIndex = this.heap.length - 1;
        while (true) {
            let leftChildIndex = index * 2 + 1;
            let rightChildIndex = index * 2 + 2;
            let swapIndex = null;

            if (leftChildIndex <= lastIndex && this.heap[leftChildIndex] > this.heap[index]) {
                swapIndex = leftChildIndex;
            }

            if (rightChildIndex <= lastIndex && this.heap[rightChildIndex] > this.heap[index]) {
                if (swapIndex === null || this.heap[rightChildIndex] > this.heap[swapIndex]) {
                    swapIndex = rightChildIndex;
                }
            }

            if (swapIndex === null) break;

            [this.heap[index], this.heap[swapIndex]] = [this.heap[swapIndex], this.heap[index]];
            index = swapIndex;
        }
    }
}