var kthSmallest = function(mat, k) {
    let m = mat.length, n = mat[0].length;
    let heap = new MinHeap();
    let sum = 0;
    for (let i = 0; i < m; i++) {
        sum += mat[i][0];
    }
    let initialIndices = new Array(m).fill(0);
    heap.insert([sum, initialIndices]);
    let visited = new Set();
    visited.add(initialIndices.join(','));

    while (k > 0) {
        let [currentSum, indices] = heap.extractMin();
        k--;
        if (k === 0) return currentSum;

        for (let i = 0; i < m; i++) {
            if (indices[i] + 1 < n) {
                let newIndices = [...indices];
                newIndices[i]++;
                let key = newIndices.join(',');
                if (!visited.has(key)) {
                    let newSum = currentSum - mat[i][indices[i]] + mat[i][newIndices[i]];
                    heap.insert([newSum, newIndices]);
                    visited.add(key);
                }
            }
        }
    }
    return -1;
};

class MinHeap {
    constructor() {
        this.heap = [];
    }

    insert(val) {
        this.heap.push(val);
        this.bubbleUp();
    }

    bubbleUp() {
        let index = this.heap.length - 1;
        while (index > 0) {
            let parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[parentIndex][0] <= this.heap[index][0]) break;
            [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
            index = parentIndex;
        }
    }

    extractMin() {
        const min = this.heap[0];
        const end = this.heap.pop();
        if (this.heap.length > 0) {
            this.heap[0] = end;
            this.sinkDown();
        }
        return min;
    }

    sinkDown() {
        let index = 0;
        const length = this.heap.length;
        while (true) {
            let leftChildIndex = 2 * index + 1;
            let rightChildIndex = 2 * index + 2;
            let swapIndex = null;

            if (leftChildIndex < length) {
                if (this.heap[leftChildIndex][0] < this.heap[index][0]) {
                    swapIndex = leftChildIndex;
                }
            }

            if (rightChildIndex < length) {
                if (
                    (swapIndex === null && this.heap[rightChildIndex][0] < this.heap[index][0]) ||
                    (swapIndex !== null && this.heap[rightChildIndex][0] < this.heap[leftChildIndex][0])
                ) {
                    swapIndex = rightChildIndex;
                }
            }

            if (swapIndex === null) break;
            [this.heap[index], this.heap[swapIndex]] = [this.heap[swapIndex], this.heap[index]];
            index = swapIndex;
        }
    }
}