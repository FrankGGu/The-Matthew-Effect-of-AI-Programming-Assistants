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

    swap(i, j) {
        [this.heap[i], this.heap[j]] = [this.heap[j], this.heap[i]];
    }

    peek() {
        if (this.heap.length === 0) {
            return null;
        }
        return this.heap[0];
    }

    insert(item) {
        this.heap.push(item);
        this.bubbleUp();
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
        this.bubbleDown();
        return item;
    }

    bubbleUp() {
        let index = this.heap.length - 1;
        while (this.hasParent(index) && this.parent(index) < this.heap[index]) {
            this.swap(index, this.getParentIndex(index));
            index = this.getParentIndex(index);
        }
    }

    bubbleDown() {
        let index = 0;
        while (this.hasLeftChild(index)) {
            let largerChildIndex = this.getLeftChildIndex(index);
            if (this.hasRightChild(index) && this.rightChild(index) > this.leftChild(index)) {
                largerChildIndex = this.getRightChildIndex(index);
            }

            if (this.heap[index] < this.heap[largerChildIndex]) {
                this.swap(index, largerChildIndex);
                index = largerChildIndex;
            } else {
                break;
            }
        }
    }
}

var maxScore = function(nums, k) {
    const maxHeap = new MaxHeap();
    for (const num of nums) {
        maxHeap.insert(num);
    }

    let score = 0;
    for (let i = 0; i < k; i++) {
        const m = maxHeap.extractMax();
        score += m;
        const new_m = Math.ceil(m / 3);
        maxHeap.insert(new_m);
    }

    return score;
};