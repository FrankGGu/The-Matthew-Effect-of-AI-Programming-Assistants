var isPossible = function(target) {
    let heap = new MaxHeap();
    let total = 0;
    for (let num of target) {
        heap.insert(num);
        total += num;
    }
    while (true) {
        let max = heap.extractMax();
        if (max === 1) return true;
        total -= max;
        if (max <= total || total < 1) return false;
        let prev = max % total;
        if (prev === 0) return total === 1;
        heap.insert(prev);
        total += prev;
    }
};

class MaxHeap {
    constructor() {
        this.heap = [];
    }

    insert(val) {
        this.heap.push(val);
        this.bubbleUp(this.heap.length - 1);
    }

    extractMax() {
        if (this.heap.length === 0) return null;
        const max = this.heap[0];
        const end = this.heap.pop();
        if (this.heap.length > 0) {
            this.heap[0] = end;
            this.sinkDown(0);
        }
        return max;
    }

    bubbleUp(index) {
        const element = this.heap[index];
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            const parent = this.heap[parentIndex];
            if (element <= parent) break;
            this.heap[parentIndex] = element;
            this.heap[index] = parent;
            index = parentIndex;
        }
    }

    sinkDown(index) {
        const leftChildIndex = 2 * index + 1;
        const rightChildIndex = 2 * index + 2;
        const length = this.heap.length;
        let largestIndex = index;

        if (leftChildIndex < length && this.heap[leftChildIndex] > this.heap[largestIndex]) {
            largestIndex = leftChildIndex;
        }
        if (rightChildIndex < length && this.heap[rightChildIndex] > this.heap[largestIndex]) {
            largestIndex = rightChildIndex;
        }
        if (largestIndex !== index) {
            const temp = this.heap[index];
            this.heap[index] = this.heap[largestIndex];
            this.heap[largestIndex] = temp;
            this.sinkDown(largestIndex);
        }
    }
}