function kthSmallest(amounts, k) {
    const minHeap = new MinHeap();
    const visited = new Set();

    minHeap.push([0, 0]);
    visited.add(0);

    while (k > 0) {
        const [sum, index] = minHeap.pop();
        k--;

        if (k === 0) return sum;

        if (index < amounts.length) {
            const nextSum = sum + amounts[index];
            const key = nextSum * 100000 + (index + 1);
            if (!visited.has(key)) {
                minHeap.push([nextSum, index + 1]);
                visited.add(key);
            }

            const key2 = sum * 100000 + (index + 1);
            if (!visited.has(key2)) {
                minHeap.push([sum, index + 1]);
                visited.add(key2);
            }
        }
    }

    return -1;
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
        const min = this.heap[0];
        const last = this.heap.pop();
        if (this.heap.length > 0) {
            this.heap[0] = last;
            this.bubbleDown(0);
        }
        return min;
    }

    bubbleUp(index) {
        const parentIndex = Math.floor((index - 1) / 2);
        if (parentIndex >= 0 && this.heap[parentIndex][0] > this.heap[index][0]) {
            [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
            this.bubbleUp(parentIndex);
        }
    }

    bubbleDown(index) {
        const leftChildIndex = 2 * index + 1;
        const rightChildIndex = 2 * index + 2;
        let smallest = index;

        if (leftChildIndex < this.heap.length && this.heap[leftChildIndex][0] < this.heap[smallest][0]) {
            smallest = leftChildIndex;
        }

        if (rightChildIndex < this.heap.length && this.heap[rightChildIndex][0] < this.heap[smallest][0]) {
            smallest = rightChildIndex;
        }

        if (smallest !== index) {
            [this.heap[index], this.heap[smallest]] = [this.heap[smallest], this.heap[index]];
            this.bubbleDown(smallest);
        }
    }
}