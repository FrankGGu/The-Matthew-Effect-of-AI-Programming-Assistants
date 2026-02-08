class MaxPriorityQueue {
    constructor() {
        this.heap = [];
    }

    _parent(i) {
        return Math.floor((i - 1) / 2);
    }

    _leftChild(i) {
        return 2 * i + 1;
    }

    _rightChild(i) {
        return 2 * i + 2;
    }

    _swap(i, j) {
        [this.heap[i], this.heap[j]] = [this.heap[j], this.heap[i]];
    }

    insert(value) {
        this.heap.push(value);
        this._heapifyUp(this.heap.length - 1);
    }

    extractMax() {
        if (this.isEmpty()) {
            return null;
        }
        if (this.heap.length === 1) {
            return this.heap.pop();
        }

        const max = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._heapifyDown(0);
        return max;
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    _heapifyUp(index) {
        let currentIndex = index;
        while (currentIndex > 0 && this.heap[currentIndex] > this.heap[this._parent(currentIndex)]) {
            this._swap(currentIndex, this._parent(currentIndex));
            currentIndex = this._parent(currentIndex);
        }
    }

    _heapifyDown(index) {
        let currentIndex = index;
        let leftChildIndex = this._leftChild(currentIndex);
        let rightChildIndex = this._rightChild(currentIndex);
        let largestIndex = currentIndex;

        if (leftChildIndex < this.heap.length && this.heap[leftChildIndex] > this.heap[largestIndex]) {
            largestIndex = leftChildIndex;
        }

        if (rightChildIndex < this.heap.length && this.heap[rightChildIndex] > this.heap[largestIndex]) {
            largestIndex = rightChildIndex;
        }

        if (largestIndex !== currentIndex) {
            this._swap(currentIndex, largestIndex);
            this._heapifyDown(largestIndex);
        }
    }
}

var minSum = function(nums, k) {
    const pq = new MaxPriorityQueue();

    for (const num of nums) {
        pq.insert(num);
    }

    for (let i = 0; i < k; i++) {
        const maxVal = pq.extractMax();
        const newVal = Math.floor(maxVal / 2);
        pq.insert(newVal);
    }

    let totalSum = 0;
    while (!pq.isEmpty()) {
        totalSum += pq.extractMax();
    }

    return totalSum;
};