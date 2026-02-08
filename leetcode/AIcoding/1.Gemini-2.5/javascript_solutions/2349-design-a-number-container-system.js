class MinHeap {
    constructor() {
        this.heap = [];
    }

    insert(val) {
        this.heap.push(val);
        this._bubbleUp(this.heap.length - 1);
    }

    peek() {
        if (this.isEmpty()) {
            return undefined;
        }
        return this.heap[0];
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

    isEmpty() {
        return this.heap.length === 0;
    }

    _bubbleUp(index) {
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[parentIndex] > this.heap[index]) {
                this._swap(parentIndex, index);
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
                this._swap(index, smallestIndex);
                index = smallestIndex;
            } else {
                break;
            }
        }
    }

    _swap(i, j) {
        [this.heap[i], this.heap[j]] = [this.heap[j], this.heap[i]];
    }
}

class NumberContainers {
    constructor() {
        this.indexToNumber = new Map();
        this.numberToIndices = new Map();
    }

    change(index, number) {
        this.indexToNumber.set(index, number);

        if (!this.numberToIndices.has(number)) {
            this.numberToIndices.set(number, new MinHeap());
        }

        this.numberToIndices.get(number).insert(index);
    }

    find(number) {
        const heap = this.numberToIndices.get(number);

        if (!heap || heap.isEmpty()) {
            return -1;
        }

        while (!heap.isEmpty()) {
            const smallestIndex = heap.peek();
            if (this.indexToNumber.get(smallestIndex) === number) {
                return smallestIndex;
            } else {
                heap.pop();
            }
        }

        return -1;
    }
}