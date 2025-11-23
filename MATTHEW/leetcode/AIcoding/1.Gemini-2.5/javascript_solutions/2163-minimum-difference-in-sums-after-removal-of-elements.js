var minimumDifference = function(nums) {
    const N = nums.length / 3;
    const totalLen = nums.length;

    // MaxPriorityQueue implementation for finding N smallest elements
    class MaxPriorityQueue {
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
            const max = this.heap[0];
            this.heap[0] = this.heap.pop();
            this._bubbleDown(0);
            return max;
        }
        peek() {
            return this.heap.length > 0 ? this.heap[0] : undefined;
        }
        size() {
            return this.heap.length;
        }
        isEmpty() {
            return this.heap.length === 0;
        }
        _bubbleUp(index) {
            while (index > 0) {
                let parentIndex = Math.floor((index - 1) / 2);
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

    // MinPriorityQueue implementation for finding N largest elements
    class MinPriorityQueue {
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
            const min = this.heap[0];
            this.heap[0] = this.heap.pop();
            this._bubbleDown(0);
            return min;
        }
        peek() {
            return this.heap.length > 0 ? this.heap[0] : undefined;
        }
        size() {
            return this.heap.length;
        }
        isEmpty() {
            return this.heap.length === 0;
        }
        _bubbleUp(index) {
            while (index > 0) {
                let parentIndex = Math.floor((index - 1) / 2);
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

    // leftMinSums[i] stores the minimum sum of N elements from nums[0...i]
    const leftMinSums = new Array(totalLen).fill(0);
    const maxHeap = new MaxPriorityQueue();
    let currentSum = 0;

    for (let i = 0; i < totalLen; i++) {
        maxHeap.push(nums[i]);
        currentSum += nums[i];
        if (maxHeap.size() > N) {
            currentSum -= maxHeap.pop();
        }
        if (maxHeap.size() === N) {
            leftMinSums[i] = currentSum;
        }
    }

    // rightMaxSums[i] stores the maximum sum of N elements from nums[i...3N-1]
    const rightMaxSums = new Array(totalLen).fill(0);
    const minHeap = new MinPriorityQueue();
    currentSum = 0;

    for (let i = totalLen - 1; i >= 0; i--) {
        minHeap.push(nums[i]);
        currentSum += nums[i];
        if (minHeap.size() > N) {
            currentSum -= minHeap.pop();
        }
        if (minHeap.size() === N) {
            rightMaxSums[i] = currentSum;
        }
    }

    let minDiff = Infinity;

    // Iterate through all possible split points 'i'.
    // 'i' represents the rightmost index of the first N elements.
    // The first N elements are chosen from nums[0...i].
    // The second N elements are chosen from nums[i+1...3N-1].
    // 'i' must be at least N-1 to have N elements in the left part.
    // 'i+1' must be at most 2N to have N elements in the right part (i.e., i <= 2N-1).
    for (let i = N - 1; i < 2 * N; i++) {
        // leftMinSums[i] is the sum of the N smallest elements from nums[0...i]
        // rightMaxSums[i+1] is the sum of the N largest elements from nums[i+1...3N-1]
        // The problem asks to minimize (sum of second half) - (sum of first half)
        minDiff = Math.min(minDiff, rightMaxSums[i+1] - leftMinSums[i]);
    }

    return minDiff;
};