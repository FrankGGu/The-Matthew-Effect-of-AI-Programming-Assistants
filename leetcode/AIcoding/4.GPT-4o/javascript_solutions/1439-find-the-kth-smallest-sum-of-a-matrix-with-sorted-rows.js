class MinHeap {
    constructor() {
        this.heap = [];
    }

    insert(value) {
        this.heap.push(value);
        this.bubbleUp();
    }

    bubbleUp() {
        let index = this.heap.length - 1;
        while (index > 0) {
            let parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[index] >= this.heap[parentIndex]) break;
            [this.heap[index], this.heap[parentIndex]] = [this.heap[parentIndex], this.heap[index]];
            index = parentIndex;
        }
    }

    remove() {
        if (this.heap.length === 0) return null;
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
        const element = this.heap[0];
        while (true) {
            let leftChildIndex = 2 * index + 1;
            let rightChildIndex = 2 * index + 2;
            let leftChild, rightChild;
            let swap = null;

            if (leftChildIndex < length) {
                leftChild = this.heap[leftChildIndex];
                if (leftChild < element) swap = leftChildIndex;
            }
            if (rightChildIndex < length) {
                rightChild = this.heap[rightChildIndex];
                if ((swap === null && rightChild < element) || (swap !== null && rightChild < leftChild)) {
                    swap = rightChildIndex;
                }
            }
            if (swap === null) break;
            this.heap[index] = this.heap[swap];
            this.heap[swap] = element;
            index = swap;
        }
    }

    size() {
        return this.heap.length;
    }
}

var kthSmallest = function(mat, k) {
    const m = mat.length;
    const n = mat[0].length;
    const minHeap = new MinHeap();
    const initialSum = mat[0][0];
    minHeap.insert({sum: initialSum, indices: [0]});
    const visited = new Set();
    visited.add(0);

    for (let i = 0; i < k - 1; i++) {
        const {sum, indices} = minHeap.remove();
        for (let j = 0; j < indices.length; j++) {
            const row = indices[j];
            if (row + 1 < m) {
                const newSum = sum - mat[row][indices[j]] + mat[row + 1][indices[j]];
                const newIndices = [...indices];
                newIndices[j] = row + 1;
                const newIndex = newIndices.join(',');
                if (!visited.has(newIndex)) {
                    visited.add(newIndex);
                    minHeap.insert({sum: newSum, indices: newIndices});
                }
            }
        }
    }
    return minHeap.remove().sum;
};