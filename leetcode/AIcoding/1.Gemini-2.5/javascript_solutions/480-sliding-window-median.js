class Heap {
    constructor(compareFn) {
        this.heap = [];
        this.compareFn = compareFn;
        this.removedCounts = new Map();
        this._size = 0;
    }

    _parent(i) { return Math.floor((i - 1) / 2); }
    _leftChild(i) { return 2 * i + 1; }
    _rightChild(i) { return 2 * i + 2; }
    _swap(i, j) {
        [this.heap[i], this.heap[j]] = [this.heap[j], this.heap[i]];
    }

    _heapifyUp(i) {
        let parentIdx = this._parent(i);
        while (i > 0 && this.compareFn(this.heap[i], this.heap[parentIdx]) < 0) {
            this._swap(i, parentIdx);
            i = parentIdx;
            parentIdx = this._parent(i);
        }
    }

    _heapifyDown(i) {
        let currentIdx = i;
        let leftChildIdx = this._leftChild(i);
        let rightChildIdx = this._rightChild(i);

        if (leftChildIdx < this.heap.length && this.compareFn(this.heap[leftChildIdx], this.heap[currentIdx]) < 0) {
            currentIdx = leftChildIdx;
        }
        if (rightChildIdx < this.heap.length && this.compareFn(this.heap[rightChildIdx], this.heap[currentIdx]) < 0) {
            currentIdx = rightChildIdx;
        }

        if (currentIdx !== i) {
            this._swap(i, currentIdx);
            this._heapifyDown(currentIdx);
        }
    }

    _trim() {
        while (this.heap.length > 0 && this.removedCounts.has(this.heap[0]) && this.removedCounts.get(this.heap[0]) > 0) {
            let val = this.heap[0];
            this.removedCounts.set(val, this.removedCounts.get(val) - 1);
            this.heap[0] = this.heap[this.heap.length - 1];
            this.heap.pop();
            this._heapifyDown(0);
        }
    }

    add(val) {
        this.heap.push(val);
        this._heapifyUp(this.heap.length - 1);
        this._size++;
    }

    peek() {
        this._trim();
        return this.heap.length > 0 ? this.heap[0] : undefined;
    }

    extract() {
        this._trim();
        if (this.heap.length === 0) return undefined;

        let val = this.heap[0];
        this.heap[0] = this.heap[this.heap.length - 1];
        this.heap.pop();
        this._heapifyDown(0);
        this._size--;
        return val;
    }

    remove(val) {
        this.removedCounts.set(val, (this.removedCounts.get(val) || 0) + 1);
        this._size--;
    }

    size() {
        return this._size;
    }
}

var medianSlidingWindow = function(nums, k) {
    const minHeap = new Heap((a, b) => a - b); 
    const maxHeap = new Heap((a, b) => b - a); 

    const result = [];

    const balanceHeaps = () => {
        while (maxHeap.size() > minHeap.size() + 1) {
            minHeap.add(maxHeap.extract());
        }
        while (minHeap.size() > maxHeap.size()) {
            maxHeap.add(minHeap.extract());
        }
    };

    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];

        if (maxHeap.size() === 0 || num <= maxHeap.peek()) {
            maxHeap.add(num);
        } else {
            minHeap.add(num);
        }

        balanceHeaps();

        if (i >= k - 1) {
            let median;
            if (k % 2 === 1) {
                median = maxHeap.peek();
            } else {
                median = (maxHeap.peek() + minHeap.peek()) / 2;
            }
            result.push(median);

            const outNum = nums[i - k + 1];

            if (outNum <= maxHeap.peek()) {
                maxHeap.remove(outNum);
            } else {
                minHeap.remove(outNum);
            }

            balanceHeaps();
        }
    }

    return result;
};