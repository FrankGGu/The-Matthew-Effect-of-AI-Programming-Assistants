var kSmallestPairs = function(nums1, nums2, k) {
    const heap = new MinHeap();
    const result = [];
    const visited = new Set();

    heap.push([0, 0, nums1[0] + nums2[0]]);
    visited.add('0,0');

    while (heap.size() > 0 && result.length < k) {
        const [i, j, _] = heap.pop();
        result.push([nums1[i], nums2[j]]);

        if (i + 1 < nums1.length && !visited.has(`${i+1},${j}`)) {
            heap.push([i + 1, j, nums1[i + 1] + nums2[j]]);
            visited.add(`${i+1},${j}`);
        }

        if (j + 1 < nums2.length && !visited.has(`${i},${j+1}`)) {
            heap.push([i, j + 1, nums1[i] + nums2[j + 1]]);
            visited.add(`${i},${j+1}`);
        }
    }

    return result;
};

class MinHeap {
    constructor() {
        this.heap = [];
    }

    size() {
        return this.heap.length;
    }

    push(val) {
        this.heap.push(val);
        this.bubbleUp(this.heap.length - 1);
    }

    pop() {
        const min = this.heap[0];
        const end = this.heap.pop();
        if (this.heap.length > 0) {
            this.heap[0] = end;
            this.bubbleDown(0);
        }
        return min;
    }

    bubbleUp(idx) {
        const element = this.heap[idx];
        while (idx > 0) {
            const parentIdx = Math.floor((idx - 1) / 2);
            const parent = this.heap[parentIdx];
            if (element[2] >= parent[2]) break;
            this.heap[idx] = parent;
            idx = parentIdx;
        }
        this.heap[idx] = element;
    }

    bubbleDown(idx) {
        const element = this.heap[idx];
        const length = this.heap.length;
        while (true) {
            let leftChildIdx = 2 * idx + 1;
            let rightChildIdx = 2 * idx + 2;
            let leftChild, rightChild;
            let swap = null;

            if (leftChildIdx < length) {
                leftChild = this.heap[leftChildIdx];
                if (leftChild[2] < element[2]) {
                    swap = leftChildIdx;
                }
            }

            if (rightChildIdx < length) {
                rightChild = this.heap[rightChildIdx];
                if (
                    (swap === null && rightChild[2] < element[2]) ||
                    (swap !== null && rightChild[2] < leftChild[2])
                ) {
                    swap = rightChildIdx;
                }
            }

            if (swap === null) break;
            this.heap[idx] = this.heap[swap];
            idx = swap;
        }
        this.heap[idx] = element;
    }
}