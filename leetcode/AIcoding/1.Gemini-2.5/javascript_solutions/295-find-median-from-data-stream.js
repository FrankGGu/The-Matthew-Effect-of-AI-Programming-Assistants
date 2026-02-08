class Heap {
    constructor(comparator = (a, b) => a - b) {
        this._heap = [];
        this._comparator = comparator;
    }

    _parent(idx) {
        return Math.floor((idx - 1) / 2);
    }

    _leftChild(idx) {
        return 2 * idx + 1;
    }

    _rightChild(idx) {
        return 2 * idx + 2;
    }

    _swap(i, j) {
        [this._heap[i], this._heap[j]] = [this._heap[j], this._heap[i]];
    }

    _bubbleUp(idx) {
        while (idx > 0 && this._comparator(this._heap[idx], this._heap[this._parent(idx)]) < 0) {
            this._swap(idx, this._parent(idx));
            idx = this._parent(idx);
        }
    }

    _sinkDown(idx) {
        let minMaxIdx = idx;
        const left = this._leftChild(idx);
        const right = this._rightChild(idx);
        const size = this._heap.length;

        if (left < size && this._comparator(this._heap[left], this._heap[minMaxIdx]) < 0) {
            minMaxIdx = left;
        }

        if (right < size && this._comparator(this._heap[right], this._heap[minMaxIdx]) < 0) {
            minMaxIdx = right;
        }

        if (minMaxIdx !== idx) {
            this._swap(idx, minMaxIdx);
            this._sinkDown(minMaxIdx);
        }
    }

    push(val) {
        this._heap.push(val);
        this._bubbleUp(this._heap.length - 1);
    }

    pop() {
        if (this.size === 0) return undefined;
        if (this.size === 1) return this._heap.pop();

        const root = this._heap[0];
        this._heap[0] = this._heap.pop();
        this._sinkDown(0);
        return root;
    }

    peek() {
        return this._heap[0];
    }

    get size() {
        return this._heap.length;
    }
}

class MedianFinder {
    constructor() {
        this.maxHeap = new Heap((a, b) => b - a); // Stores the smaller half, largest element at top
        this.minHeap = new Heap((a, b) => a - b); // Stores the larger half, smallest element at top
    }

    addNum(num) {
        if (this.maxHeap.size === 0 || num <= this.maxHeap.peek()) {
            this.maxHeap.push(num);
        } else {
            this.minHeap.push(num);
        }

        // Balance the heaps
        if (this.maxHeap.size > this.minHeap.size + 1) {
            this.minHeap.push(this.maxHeap.pop());
        } else if (this.minHeap.size > this.maxHeap.size) {
            this.maxHeap.push(this.minHeap.pop());
        }
    }

    findMedian() {
        if (this.maxHeap.size === 0) {
            return null; 
        }

        if (this.maxHeap.size === this.minHeap.size) {
            return (this.maxHeap.peek() + this.minHeap.peek()) / 2;
        } else {
            return this.maxHeap.peek();
        }
    }
}