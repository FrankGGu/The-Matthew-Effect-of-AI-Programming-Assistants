class MaxHeap {
    constructor() {
        this.heap = [];
    }

    getParentIndex(i) {
        return Math.floor((i - 1) / 2);
    }

    getLeftChildIndex(i) {
        return 2 * i + 1;
    }

    getRightChildIndex(i) {
        return 2 * i + 2;
    }

    hasParent(i) {
        return this.getParentIndex(i) >= 0;
    }

    hasLeftChild(i) {
        return this.getLeftChildIndex(i) < this.heap.length;
    }

    hasRightChild(i) {
        return this.getRightChildIndex(i) < this.heap.length;
    }

    parent(i) {
        return this.heap[this.getParentIndex(i)];
    }

    leftChild(i) {
        return this.heap[this.getLeftChildIndex(i)];
    }

    rightChild(i) {
        return this.heap[this.getRightChildIndex(i)];
    }

    swap(i1, i2) {
        [this.heap[i1], this.heap[i2]] = [this.heap[i2], this.heap[i1]];
    }

    peek() {
        if (this.heap.length === 0) {
            return null;
        }
        return this.heap[0];
    }

    insert(item) {
        this.heap.push(item);
        this.heapifyUp();
    }

    extractMax() {
        if (this.heap.length === 0) {
            return null;
        }
        if (this.heap.length === 1) {
            return this.heap.pop();
        }

        const item = this.heap[0];
        this.heap[0] = this.heap.pop();
        this.heapifyDown();
        return item;
    }

    heapifyUp() {
        let index = this.heap.length - 1;
        while (this.hasParent(index) && this.parent(index) < this.heap[index]) {
            this.swap(this.getParentIndex(index), index);
            index = this.getParentIndex(index);
        }
    }

    heapifyDown() {
        let index = 0;
        while (this.hasLeftChild(index)) {
            let largerChildIndex = this.getLeftChildIndex(index);
            if (this.hasRightChild(index) && this.rightChild(index) > this.leftChild(index)) {
                largerChildIndex = this.getRightChildIndex(index);
            }

            if (this.heap[index] > this.heap[largerChildIndex]) {
                break;
            } else {
                this.swap(index, largerChildIndex);
            }
            index = largerChildIndex;
        }
    }

    size() {
        return this.heap.length;
    }
}

var pickGifts = function(piles, k) {
    const maxHeap = new MaxHeap();
    for (const pile of piles) {
        maxHeap.insert(pile);
    }

    for (let i = 0; i < k; i++) {
        const largest = maxHeap.extractMax();
        const newPile = Math.floor(Math.sqrt(largest));
        maxHeap.insert(newPile);
    }

    let totalGifts = 0;
    while (maxHeap.size() > 0) {
        totalGifts += maxHeap.extractMax();
    }

    return totalGifts;
};