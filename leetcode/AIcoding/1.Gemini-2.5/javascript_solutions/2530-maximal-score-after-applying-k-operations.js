class MaxPriorityQueue {
    constructor() {
        this.heap = [];
    }

    _swap(i, j) {
        [this.heap[i], this.heap[j]] = [this.heap[j], this.heap[i]];
    }

    _siftUp(idx) {
        let parentIdx = Math.floor((idx - 1) / 2);
        while (idx > 0 && this.heap[idx][0] > this.heap[parentIdx][0]) {
            this._swap(idx, parentIdx);
            idx = parentIdx;
            parentIdx = Math.floor((idx - 1) / 2);
        }
    }

    _siftDown(idx) {
        let leftChildIdx = 2 * idx + 1;
        let rightChildIdx = 2 * idx + 2;
        let largestIdx = idx;

        if (leftChildIdx < this.heap.length && this.heap[leftChildIdx][0] > this.heap[largestIdx][0]) {
            largestIdx = leftChildIdx;
        }

        if (rightChildIdx < this.heap.length && this.heap[rightChildIdx][0] > this.heap[largestIdx][0]) {
            largestIdx = rightChildIdx;
        }

        if (largestIdx !== idx) {
            this._swap(idx, largestIdx);
            this._siftDown(largestIdx);
        }
    }

    push(value) {
        this.heap.push(value);
        this._siftUp(this.heap.length - 1);
    }

    pop() {
        if (this.isEmpty()) {
            return null;
        }
        if (this.heap.length === 1) {
            return this.heap.pop();
        }
        const max = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._siftDown(0);
        return max;
    }

    peek() {
        return this.isEmpty() ? null : this.heap[0];
    }

    isEmpty() {
        return this.heap.length === 0;
    }
}

var maxResult = function(nums, k) {
    const n = nums.length;
    if (n === 0) return 0;

    const pq = new MaxPriorityQueue(); // Stores [score, index]

    pq.push([nums[0], 0]);
    let currentMaxScore = nums[0];

    for (let i = 1; i < n; i++) {
        // Remove elements from the heap whose index is outside the sliding window [i - k, i - 1]
        while (pq.peek()[1] < i - k) {
            pq.pop();
        }

        // The top of the heap contains the maximum score from the valid window
        // This is equivalent to dp[i-1] for some i-1 in the window
        currentMaxScore = nums[i] + pq.peek()[0];

        // Add the current score and index to the heap
        pq.push([currentMaxScore, i]);
    }

    return currentMaxScore;
};