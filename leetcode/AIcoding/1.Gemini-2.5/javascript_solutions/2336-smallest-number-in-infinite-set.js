class MinHeap {
    constructor() {
        this.heap = [];
    }

    push(val) {
        this.heap.push(val);
        this._bubbleUp(this.heap.length - 1);
    }

    pop() {
        if (this.isEmpty()) {
            return undefined;
        }
        if (this.heap.length === 1) {
            return this.heap.pop();
        }
        const min = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._bubbleDown(0);
        return min;
    }

    peek() {
        return this.heap[0];
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    _bubbleUp(index) {
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[parentIndex] > this.heap[index]) {
                [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
                index = parentIndex;
            } else {
                break;
            }
        }
    }

    _bubbleDown(index) {
        const lastIndex = this.heap.length - 1;
        while (true) {
            let leftChildIndex = 2 * index + 1;
            let rightChildIndex = 2 * index + 2;
            let smallestIndex = index;

            if (leftChildIndex <= lastIndex && this.heap[leftChildIndex] < this.heap[smallestIndex]) {
                smallestIndex = leftChildIndex;
            }
            if (rightChildIndex <= lastIndex && this.heap[rightChildIndex] < this.heap[smallestIndex]) {
                smallestIndex = rightChildIndex;
            }

            if (smallestIndex !== index) {
                [this.heap[index], this.heap[smallestIndex]] = [this.heap[smallestIndex], this.heap[index]];
                index = smallestIndex;
            } else {
                break;
            }
        }
    }
}

class SmallestInfiniteSet {
    constructor() {
        this.nextSmallest = 1;
        this.addedBackNumbers = new MinHeap();
        this.inAddedBackSet = new Set();
    }

    popSmallest() {
        if (!this.addedBackNumbers.isEmpty()) {
            const smallest = this.addedBackNumbers.pop();
            this.inAddedBackSet.delete(smallest);
            return smallest;
        } else {
            const smallest = this.nextSmallest;
            this.nextSmallest++;
            return smallest;
        }
    }

    addBack(num) {
        if (num < this.nextSmallest && !this.inAddedBackSet.has(num)) {
            this.addedBackNumbers.push(num);
            this.inAddedBackSet.add(num);
        }
    }
}