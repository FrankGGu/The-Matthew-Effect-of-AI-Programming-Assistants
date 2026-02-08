class MinPriorityQueue {
    constructor() {
        this.heap = [];
    }

    push(item) {
        this.heap.push(item);
        this._bubbleUp(this.heap.length - 1);
    }

    pop() {
        if (this.isEmpty()) {
            return null;
        }
        if (this.heap.length === 1) {
            return this.heap.pop();
        }
        const root = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._bubbleDown(0);
        return root;
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
            let leftChildIndex = 2 * index + 1;
            let rightChildIndex = 2 * index + 2;
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

var kSmallestPairs = function(nums1, nums2, k) {
    const result = [];
    if (nums1.length === 0 || nums2.length === 0 || k === 0) {
        return result;
    }

    const pq = new MinPriorityQueue();

    for (let i = 0; i < nums1.length && i < k; i++) {
        pq.push([nums1[i] + nums2[0], i, 0]);
    }

    while (k > 0 && !pq.isEmpty()) {
        const [sum, i, j] = pq.pop();
        result.push([nums1[i], nums2[j]]);
        k--;

        if (j + 1 < nums2.length) {
            pq.push([nums1[i] + nums2[j + 1], i, j + 1]);
        }
    }

    return result;
};