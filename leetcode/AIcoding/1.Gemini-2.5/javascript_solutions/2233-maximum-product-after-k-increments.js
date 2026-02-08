class MinHeap {
    constructor(array = []) {
        this.heap = [];
        if (array.length > 0) {
            for (let x of array) {
                this.push(x);
            }
        }
    }

    _getParentIndex(i) {
        return Math.floor((i - 1) / 2);
    }

    _getLeftChildIndex(i) {
        return 2 * i + 1;
    }

    _getRightChildIndex(i) {
        return 2 * i + 2;
    }

    _hasParent(i) {
        return this._getParentIndex(i) >= 0;
    }

    _hasLeftChild(i) {
        return this._getLeftChildIndex(i) < this.heap.length;
    }

    _hasRightChild(i) {
        return this._getRightChildIndex(i) < this.heap.length;
    }

    _getParent(i) {
        return this.heap[this._getParentIndex(i)];
    }

    _getLeftChild(i) {
        return this.heap[this._getLeftChildIndex(i)];
    }

    _getRightChild(i) {
        return this.heap[this._getRightChildIndex(i)];
    }

    _swap(i, j) {
        [this.heap[i], this.heap[j]] = [this.heap[j], this.heap[i]];
    }

    peek() {
        if (this.heap.length === 0) {
            return null;
        }
        return this.heap[0];
    }

    push(item) {
        this.heap.push(item);
        this._heapifyUp();
    }

    pop() {
        if (this.heap.length === 0) {
            return null;
        }
        if (this.heap.length === 1) {
            return this.heap.pop();
        }

        const item = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._heapifyDown();
        return item;
    }

    _heapifyUp() {
        let currentIndex = this.heap.length - 1;
        while (
            this._hasParent(currentIndex) &&
            this._getParent(currentIndex) > this.heap[currentIndex]
        ) {
            this._swap(currentIndex, this._getParentIndex(currentIndex));
            currentIndex = this._getParentIndex(currentIndex);
        }
    }

    _heapifyDown() {
        let currentIndex = 0;
        while (this._hasLeftChild(currentIndex)) {
            let smallerChildIndex = this._getLeftChildIndex(currentIndex);
            if (
                this._hasRightChild(currentIndex) &&
                this._getRightChild(currentIndex) < this._getLeftChild(currentIndex)
            ) {
                smallerChildIndex = this._getRightChildIndex(currentIndex);
            }

            if (this.heap[currentIndex] < this.heap[smallerChildIndex]) {
                break;
            } else {
                this._swap(currentIndex, smallerChildIndex);
            }
            currentIndex = smallerChildIndex;
        }
    }

    size() {
        return this.heap.length;
    }
}

var maximumProduct = function(nums, k) {
    const MOD = 10**9 + 7;
    const minHeap = new MinHeap(nums);

    for (let i = 0; i < k; i++) {
        const smallest = minHeap.pop();
        minHeap.push(smallest + 1);
    }

    let product = 1;
    while (minHeap.size() > 0) {
        product = (product * minHeap.pop()) % MOD;
    }

    return product;
};