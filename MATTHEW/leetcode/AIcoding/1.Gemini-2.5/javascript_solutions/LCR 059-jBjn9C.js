class MinHeap {
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

    push(val) {
        this.heap.push(val);
        this._heapifyUp(this.heap.length - 1);
    }

    pop() {
        if (this.heap.length === 0) return null;
        if (this.heap.length === 1) return this.heap.pop();

        const root = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._heapifyDown(0);
        return root;
    }

    peek() {
        return this.heap.length > 0 ? this.heap[0] : null;
    }

    size() {
        return this.heap.length;
    }

    _heapifyUp(index) {
        let currentIndex = index;
        while (currentIndex > 0 && this.heap[currentIndex] < this.heap[this._parent(currentIndex)]) {
            this._swap(currentIndex, this._parent(currentIndex));
            currentIndex = this._parent(currentIndex);
        }
    }

    _heapifyDown(index) {
        let currentIndex = index;
        const lastIndex = this.heap.length - 1;

        while (true) {
            let leftChildIndex = this._leftChild(currentIndex);
            let rightChildIndex = this._rightChild(currentIndex);
            let smallestIndex = currentIndex;

            if (leftChildIndex <= lastIndex && this.heap[leftChildIndex] < this.heap[smallestIndex]) {
                smallestIndex = leftChildIndex;
            }

            if (rightChildIndex <= lastIndex && this.heap[rightChildIndex] < this.heap[smallestIndex]) {
                smallestIndex = rightChildIndex;
            }

            if (smallestIndex !== currentIndex) {
                this._swap(currentIndex, smallestIndex);
                currentIndex = smallestIndex;
            } else {
                break;
            }
        }
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
        this.minHeap.push(val);
        if (this.minHeap.size() > this.k) {
            this.minHeap.pop();
        }
        return this.minHeap.peek();
    }
}