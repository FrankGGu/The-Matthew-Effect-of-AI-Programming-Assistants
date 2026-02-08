var mincostToHireWorkers = function(quality, wage, K) {
    const workers = quality.map((q, i) => [wage[i] / q, q]);
    workers.sort((a, b) => a[0] - b[0]);

    const minHeap = new MinHeap();
    let qualitySum = 0;
    let result = Infinity;

    for (const [ratio, q] of workers) {
        minHeap.add(q);
        qualitySum += q;

        if (minHeap.size() > K) {
            qualitySum -= minHeap.remove();
        }

        if (minHeap.size() === K) {
            result = Math.min(result, ratio * qualitySum);
        }
    }

    return result;
};

class MinHeap {
    constructor() {
        this.heap = [];
    }

    add(val) {
        this.heap.push(val);
        this.bubbleUp();
    }

    remove() {
        if (this.heap.length < 2) return this.heap.pop();
        const root = this.heap[0];
        this.heap[0] = this.heap.pop();
        this.bubbleDown();
        return root;
    }

    size() {
        return this.heap.length;
    }

    bubbleUp() {
        let index = this.heap.length - 1;
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[index] >= this.heap[parentIndex]) break;
            [this.heap[index], this.heap[parentIndex]] = [this.heap[parentIndex], this.heap[index]];
            index = parentIndex;
        }
    }

    bubbleDown() {
        let index = 0;
        const length = this.heap.length;
        while (true) {
            let leftChildIndex = 2 * index + 1;
            let rightChildIndex = 2 * index + 2;
            let smallestIndex = index;

            if (leftChildIndex < length && this.heap[leftChildIndex] < this.heap[smallestIndex]) {
                smallestIndex = leftChildIndex;
            }
            if (rightChildIndex < length && this.heap[rightChildIndex] < this.heap[smallestIndex]) {
                smallestIndex = rightChildIndex;
            }
            if (smallestIndex === index) break;
            [this.heap[index], this.heap[smallestIndex]] = [this.heap[smallestIndex], this.heap[index]];
            index = smallestIndex;
        }
    }
}