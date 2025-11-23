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
            return null;
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

    size() {
        return this.heap.length;
    }

    _bubbleUp(index) {
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[parentIndex][0] > this.heap[index][0]) {
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
            const leftChildIndex = 2 * index + 1;
            const rightChildIndex = 2 * index + 2;
            let smallestIndex = index;

            if (leftChildIndex <= lastIndex && this.heap[leftChildIndex][0] < this.heap[smallestIndex][0]) {
                smallestIndex = leftChildIndex;
            }

            if (rightChildIndex <= lastIndex && this.heap[rightChildIndex][0] < this.heap[smallestIndex][0]) {
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

var kthSmallest = function(mat, k) {
    let currentSums = mat[0];

    for (let i = 1; i < mat.length; i++) {
        const A = currentSums;
        const B = mat[i];
        const nextSums = [];
        const minHeap = new MinHeap();
        const visited = new Set();

        const initialSum = A[0] + B[0];
        minHeap.push([initialSum, 0, 0]);
        visited.add("0,0");

        while (nextSums.length < k && !minHeap.isEmpty()) {
            const [currentSum, idxA, idxB] = minHeap.pop();
            nextSums.push(currentSum);

            if (idxA + 1 < A.length) {
                const newIdxA = idxA + 1;
                const key = `${newIdxA},${idxB}`;
                if (!visited.has(key)) {
                    minHeap.push([A[newIdxA] + B[idxB], newIdxA, idxB]);
                    visited.add(key);
                }
            }

            if (idxB + 1 < B.length) {
                const newIdxB = idxB + 1;
                const key = `${idxA},${newIdxB}`;
                if (!visited.has(key)) {
                    minHeap.push([A[idxA] + B[newIdxB], idxA, newIdxB]);
                    visited.add(key);
                }
            }
        }
        currentSums = nextSums;
    }

    return currentSums[k - 1];
};