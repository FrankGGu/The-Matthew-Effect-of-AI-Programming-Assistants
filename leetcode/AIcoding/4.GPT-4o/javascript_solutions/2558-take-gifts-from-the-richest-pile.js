function pickGifts(gifts, k) {
    let maxHeap = new MaxHeap();
    for (let gift of gifts) {
        maxHeap.insert(gift);
    }
    for (let i = 0; i < k; i++) {
        let largest = maxHeap.extractMax();
        maxHeap.insert(Math.floor(Math.sqrt(largest)));
    }
    let total = 0;
    while (maxHeap.size() > 0) {
        total += maxHeap.extractMax();
    }
    return total;
}

class MaxHeap {
    constructor() {
        this.heap = [];
    }

    insert(val) {
        this.heap.push(val);
        this.bubbleUp();
    }

    extractMax() {
        if (this.heap.length === 0) return null;
        const max = this.heap[0];
        const end = this.heap.pop();
        if (this.heap.length > 0) {
            this.heap[0] = end;
            this.bubbleDown();
        }
        return max;
    }

    bubbleUp() {
        let index = this.heap.length - 1;
        while (index > 0) {
            let parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[parentIndex] >= this.heap[index]) break;
            [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
            index = parentIndex;
        }
    }

    bubbleDown() {
        let index = 0;
        const length = this.heap.length;
        while (true) {
            let leftIndex = 2 * index + 1;
            let rightIndex = 2 * index + 2;
            let largestIndex = index;

            if (leftIndex < length && this.heap[leftIndex] > this.heap[largestIndex]) {
                largestIndex = leftIndex;
            }
            if (rightIndex < length && this.heap[rightIndex] > this.heap[largestIndex]) {
                largestIndex = rightIndex;
            }
            if (largestIndex === index) break;
            [this.heap[index], this.heap[largestIndex]] = [this.heap[largestIndex], this.heap[index]];
            index = largestIndex;
        }
    }

    size() {
        return this.heap.length;
    }
}