function maxAverageRatio(classes, extraStudents) {
    const n = classes.length;
    const heap = new MaxHeap();

    for (let i = 0; i < n; i++) {
        heap.insert([classes[i][0], classes[i][1]]);
    }

    for (let i = 0; i < extraStudents; i++) {
        const [pass, total] = heap.extractMax();
        heap.insert([pass + 1, total + 1]);
    }

    let totalAverage = 0;
    while (heap.size() > 0) {
        const [pass, total] = heap.extractMax();
        totalAverage += pass / total;
    }

    return totalAverage / n;
}

class MaxHeap {
    constructor() {
        this.heap = [];
    }

    insert([pass, total]) {
        this.heap.push([pass, total]);
        this.bubbleUp();
    }

    extractMax() {
        if (this.heap.length === 0) return null;
        if (this.heap.length === 1) return this.heap.pop();
        const max = this.heap[0];
        this.heap[0] = this.heap.pop();
        this.bubbleDown();
        return max;
    }

    bubbleUp() {
        let index = this.heap.length - 1;
        while (index > 0) {
            let parentIndex = Math.floor((index - 1) / 2);
            if (this.compare(this.heap[index], this.heap[parentIndex]) <= 0) break;
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
            let largestIndex = index;

            if (leftChildIndex < length && this.compare(this.heap[leftChildIndex], this.heap[largestIndex]) > 0) {
                largestIndex = leftChildIndex;
            }
            if (rightChildIndex < length && this.compare(this.heap[rightChildIndex], this.heap[largestIndex]) > 0) {
                largestIndex = rightChildIndex;
            }
            if (largestIndex === index) break;
            [this.heap[index], this.heap[largestIndex]] = [this.heap[largestIndex], this.heap[index]];
            index = largestIndex;
        }
    }

    compare([pass1, total1], [pass2, total2]) {
        const avg1 = pass1 / total1;
        const avg2 = pass2 / total2;
        const diff = avg1 - avg2;
        if (diff !== 0) return diff > 0 ? 1 : -1;
        return (total2 - total1) > 0 ? 1 : -1;
    }

    size() {
        return this.heap.length;
    }
}