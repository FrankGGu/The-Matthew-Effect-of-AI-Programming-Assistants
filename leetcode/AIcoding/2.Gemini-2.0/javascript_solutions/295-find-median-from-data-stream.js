class MedianFinder {
    constructor() {
        this.minHeap = [];
        this.maxHeap = [];
    }

    addNum(num) {
        if (this.maxHeap.length === 0 || num <= this.maxHeap[0]) {
            this.maxHeap.push(num);
            this.heapifyMax(this.maxHeap);
        } else {
            this.minHeap.push(num);
            this.heapifyMin(this.minHeap);
        }

        if (this.maxHeap.length > this.minHeap.length + 1) {
            this.minHeap.push(this.maxHeap[0]);
            this.maxHeap[0] = this.maxHeap.pop();
            this.heapifyMax(this.maxHeap);
            this.heapifyMin(this.minHeap);
        } else if (this.minHeap.length > this.maxHeap.length) {
            this.maxHeap.push(this.minHeap[0]);
            this.minHeap[0] = this.minHeap.pop();
            this.heapifyMin(this.minHeap);
            this.heapifyMax(this.maxHeap);
        }
    }

    findMedian() {
        if ((this.maxHeap.length + this.minHeap.length) % 2 === 0) {
            return (this.maxHeap[0] + this.minHeap[0]) / 2;
        } else {
            return this.maxHeap[0];
        }
    }

    heapifyMax(heap) {
        for (let i = Math.floor(heap.length / 2) - 1; i >= 0; i--) {
            this.maxHeapify(heap, i);
        }
    }

    heapifyMin(heap) {
        for (let i = Math.floor(heap.length / 2) - 1; i >= 0; i--) {
            this.minHeapify(heap, i);
        }
    }

    maxHeapify(heap, i) {
        let largest = i;
        let left = 2 * i + 1;
        let right = 2 * i + 2;

        if (left < heap.length && heap[left] > heap[largest]) {
            largest = left;
        }

        if (right < heap.length && heap[right] > heap[largest]) {
            largest = right;
        }

        if (largest !== i) {
            [heap[i], heap[largest]] = [heap[largest], heap[i]];
            this.maxHeapify(heap, largest);
        }
    }

    minHeapify(heap, i) {
        let smallest = i;
        let left = 2 * i + 1;
        let right = 2 * i + 2;

        if (left < heap.length && heap[left] < heap[smallest]) {
            smallest = left;
        }

        if (right < heap.length && heap[right] < heap[smallest]) {
            smallest = right;
        }

        if (smallest !== i) {
            [heap[i], heap[smallest]] = [heap[smallest], heap[i]];
            this.minHeapify(heap, smallest);
        }
    }
}