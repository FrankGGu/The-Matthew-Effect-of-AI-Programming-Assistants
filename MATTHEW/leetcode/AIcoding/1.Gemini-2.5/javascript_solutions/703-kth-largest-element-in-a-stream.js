class MinHeap {
    constructor() {
        this.heap = [];
    }

    _getParentIdx(idx) {
        return Math.floor((idx - 1) / 2);
    }

    _getLeftChildIdx(idx) {
        return 2 * idx + 1;
    }

    _getRightChildIdx(idx) {
        return 2 * idx + 2;
    }

    _swap(i, j) {
        [this.heap[i], this.heap[j]] = [this.heap[j], this.heap[i]];
    }

    _siftUp(idx) {
        let currentIdx = idx;
        let parentIdx = this._getParentIdx(currentIdx);
        while (currentIdx > 0 && this.heap[currentIdx] < this.heap[parentIdx]) {
            this._swap(currentIdx, parentIdx);
            currentIdx = parentIdx;
            parentIdx = this._getParentIdx(currentIdx);
        }
    }

    _siftDown(idx) {
        let currentIdx = idx;
        let leftChildIdx = this._getLeftChildIdx(currentIdx);
        let rightChildIdx = this._getRightChildIdx(currentIdx);
        let smallestIdx = currentIdx;

        if (leftChildIdx < this.heap.length && this.heap[leftChildIdx] < this.heap[smallestIdx]) {
            smallestIdx = leftChildIdx;
        }

        if (rightChildIdx < this.heap.length && this.heap[rightChildIdx] < this.heap[smallestIdx]) {
            smallestIdx = rightChildIdx;
        }

        if (smallestIdx !== currentIdx) {
            this._swap(currentIdx, smallestIdx);
            this._siftDown(smallestIdx);
        }
    }

    push(val) {
        this.heap.push(val);
        this._siftUp(this.heap.length - 1);
    }

    pop() {
        if (this.heap.length === 0) {
            return undefined;
        }
        if (this.heap.length === 1) {
            return this.heap.pop();
        }

        const min = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._siftDown(0);
        return min;
    }

    peek() {
        return this.heap.length === 0 ? undefined : this.heap[0];
    }

    size() {
        return this.heap.length;
    }
}

class KthLargest {
    constructor(k, nums) {
        this.k = k;
        this.minHeap = new MinHeap();

        for (const num of nums) {
            this.add(num);
        }
    }

    add(val) {
        if (this.minHeap.size() < this.k) {
            this.minHeap.push(val);
        } else if (val > this.minHeap.peek()) {
            this.minHeap.pop();
            this.minHeap.push(val);
        }
        return this.minHeap.peek();
    }
}