class MinHeap {
    constructor() {
        this.heap = [];
    }

    push(val) {
        this.heap.push(val);
        this._heapifyUp(this.heap.length - 1);
    }

    pop() {
        if (this.isEmpty()) return null;
        if (this.heap.length === 1) return this.heap.pop();

        const root = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._heapifyDown(0);
        return root;
    }

    peek() {
        return this.isEmpty() ? null : this.heap[0];
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    get size() {
        return this.heap.length;
    }

    _heapifyUp(index) {
        let parentIndex = Math.floor((index - 1) / 2);
        while (index > 0 && this.heap[index] < this.heap[parentIndex]) {
            this._swap(index, parentIndex);
            index = parentIndex;
            parentIndex = Math.floor((index - 1) / 2);
        }
    }

    _heapifyDown(index) {
        let leftChildIndex = 2 * index + 1;
        let rightChildIndex = 2 * index + 2;
        let smallestIndex = index;

        if (leftChildIndex < this.heap.length && this.heap[leftChildIndex] < this.heap[smallestIndex]) {
            smallestIndex = leftChildIndex;
        }

        if (rightChildIndex < this.heap.length && this.heap[rightChildIndex] < this.heap[smallestIndex]) {
            smallestIndex = rightChildIndex;
        }

        if (smallestIndex !== index) {
            this._swap(index, smallestIndex);
            this._heapifyDown(smallestIndex);
        }
    }

    _swap(i, j) {
        [this.heap[i], this.heap[j]] = [this.heap[j], this.heap[i]];
    }
}

class MaxHeap {
    constructor() {
        this.heap = [];
    }

    push(val) {
        this.heap.push(val);
        this._heapifyUp(this.heap.length - 1);
    }

    pop() {
        if (this.isEmpty()) return null;
        if (this.heap.length === 1) return this.heap.pop();

        const root = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._heapifyDown(0);
        return root;
    }

    peek() {
        return this.isEmpty() ? null : this.heap[0];
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    get size() {
        return this.heap.length;
    }

    _heapifyUp(index) {
        let parentIndex = Math.floor((index - 1) / 2);
        while (index > 0 && this.heap[index] > this.heap[parentIndex]) {
            this._swap(index, parentIndex);
            index = parentIndex;
            parentIndex = Math.floor((index - 1) / 2);
        }
    }

    _heapifyDown(index) {
        let leftChildIndex = 2 * index + 1;
        let rightChildIndex = 2 * index + 2;
        let largestIndex = index;

        if (leftChildIndex < this.heap.length && this.heap[leftChildIndex] > this.heap[largestIndex]) {
            largestIndex = leftChildIndex;
        }

        if (rightChildIndex < this.heap.length && this.heap[rightChildIndex] > this.heap[largestIndex]) {
            largestIndex = rightChildIndex;
        }

        if (largestIndex !== index) {
            this._swap(index, largestIndex);
            this._heapifyDown(largestIndex);
        }
    }

    _swap(i, j) {
        [this.heap[i], this.heap[j]] = [this.heap[j], this.heap[i]];
    }
}

var MedianFinder = function() {
    this.minHeap = new MinHeap(); // Stores larger half, smallest element at top
    this.maxHeap = new MaxHeap(); // Stores smaller half, largest element at top
};

MedianFinder.prototype.addNum = function(num) {
    if (this.maxHeap.isEmpty() || num <= this.maxHeap.peek()) {
        this.maxHeap.push(num);
    } else {
        this.minHeap.push(num);
    }

    // Balance the heaps
    // MaxHeap can have at most 1 more element than MinHeap
    if (this.maxHeap.size > this.minHeap.size + 1) {
        this.minHeap.push(this.maxHeap.pop());
    } else if (this.minHeap.size > this.maxHeap.size) {
        this.maxHeap.push(this.minHeap.pop());
    }
};

MedianFinder.prototype.findMedian = function() {
    if (this.maxHeap.size === this.minHeap.size) {
        return (this.maxHeap.peek() + this.minHeap.peek()) / 2;
    } else {
        return this.maxHeap.peek();
    }
};