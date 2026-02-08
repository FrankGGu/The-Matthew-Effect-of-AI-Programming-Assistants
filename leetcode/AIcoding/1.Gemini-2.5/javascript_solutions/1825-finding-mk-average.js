class MinHeap {
    constructor() {
        this.heap = [];
    }

    push(val) {
        this.heap.push(val);
        this._bubbleUp(this.heap.length - 1);
    }

    pop() {
        if (this.isEmpty()) return undefined;
        if (this.heap.length === 1) return this.heap.pop();
        const root = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._bubbleDown(0);
        return root;
    }

    peek() {
        return this.heap[0];
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    size() {
        return this.heap.length;
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

class MaxHeap {
    constructor() {
        this.heap = [];
    }

    push(val) {
        this.heap.push(val);
        this._bubbleUp(this.heap.length - 1);
    }

    pop() {
        if (this.isEmpty()) return undefined;
        if (this.heap.length === 1) return this.heap.pop();
        const root = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._bubbleDown(0);
        return root;
    }

    peek() {
        return this.heap[0];
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    size() {
        return this.heap.length;
    }

    _bubbleUp(index) {
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[parentIndex] < this.heap[index]) {
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
            let largestIndex = index;

            if (leftChildIndex <= lastIndex && this.heap[leftChildIndex] > this.heap[largestIndex]) {
                largestIndex = leftChildIndex;
            }
            if (rightChildIndex <= lastIndex && this.heap[rightChildIndex] > this.heap[largestIndex]) {
                largestIndex = rightChildIndex;
            }

            if (largestIndex !== index) {
                [this.heap[index], this.heap[largestIndex]] = [this.heap[largestIndex], this.heap[index]];
                index = largestIndex;
            } else {
                break;
            }
        }
    }
}

class MKAverage {
    constructor(m, k) {
        this.m = m;
        this.k = k;
        this.q = []; // Deque to store the last m elements

        this.left = new MaxHeap(); // Stores k smallest elements
        this.mid = new MinHeap();  // Stores m - 2k middle elements
        this.right = new MinHeap(); // Stores k largest elements

        this.midSum = 0;
        this.removed = new Map(); // For lazy deletion: stores count of elements removed from queue but still in heaps
    }

    _cleanTop(heap) {
        while (!heap.isEmpty() && this.removed.has(heap.peek()) && this.removed.get(heap.peek()) > 0) {
            const val = heap.pop();
            this.removed.set(val, this.removed.get(val) - 1);
        }
    }

    _getTop(heap) {
        this._cleanTop(heap);
        return heap.peek();
    }

    _popTop(heap) {
        this._cleanTop(heap);
        const val = heap.pop();
        return val;
    }

    _pushToHeap(heap, val, isMidHeap) {
        heap.push(val);
        if (isMidHeap) {
            this.midSum += val;
        }
    }

    _popFromHeap(heap, isMidHeap) {
        const val = this._popTop(heap);
        if (isMidHeap) {
            this.midSum -= val;
        }
        return val;
    }

    _move(fromHeap, toHeap, isFromMid, isToMid) {
        const val = this._popFromHeap(fromHeap, isFromMid);
        this._pushToHeap(toHeap, val, isToMid);
    }

    _balanceHeaps() {
        // Ensure heaps are clean before checking sizes and peeks
        this._cleanTop(this.left);
        this._cleanTop(this.mid);
        this._cleanTop(this.right);

        // Phase 1: Ensure correct sizes
        while (this.left.size() > this.k) {
            this._move(this.left, this.mid, false, true);
        }
        while (this.right.size() > this.k) {
            this._move(this.right, this.mid, false, true);
        }
        while (this.mid.size() > this.m - 2 * this.k) {
            // If left needs more elements, move from mid to left
            if (this.left.size() < this.k) {
                this._move(this.mid, this.left, true, false);
            } else { // Otherwise, move from mid to right
                this._move(this.mid, this.right, true, false);
            }
        }

        // Phase 2: Fill up smaller heaps if possible
        while (this.left.size() < this.k && this.mid.size() > 0) {
            this._move(this.mid, this.left, true, false);
        }
        while (this.right.size() < this.k && this.mid.size() > 0) {
            this._move(this.mid, this.right, true, false);
        }

        // Phase 3: Ensure correct ordering (left.peek <= mid.peek <= right.peek)
        // Swap if left's max is greater than mid's min
        while (this.left.size() > 0 && this.mid.size() > 0 && this._getTop(this.left) > this._getTop(this.mid)) {
            this._move(this.left, this.mid, false, true);
            this._move(this.mid, this.left, true, false);
        }
        // Swap if mid's min is greater than right's min
        while (this.mid.size() > 0 && this.right.size() > 0 && this._getTop(this.mid) > this._getTop(this.right)) {
            this._move(this.mid, this.right, true, false);
            this._move(this.right, this.mid, false, true);
        }
    }

    addNum(num) {
        this.q.push(num);
        this._pushToHeap(this.mid, num, true); // Initially push to mid, then balance

        if (this.q.length > this.m) {
            const oldNum = this.q.shift();
            this.removed.set(oldNum, (this.removed.get(oldNum) || 0) + 1);
        }

        this._balanceHeaps();
    }

    calculateMKAverage() {
        if (this.q.length < this.m) {
            return -1;
        }

        // Ensure heaps are balanced before calculating
        this._balanceHeaps();

        // The number of elements in the middle section should be m - 2k
        const count = this.m - 2 * this.k;
        if (count <= 0) { // Should not happen based on constraints, but good for robustness
            return 0;
        }
        return Math.floor(this.midSum / count);
    }
}