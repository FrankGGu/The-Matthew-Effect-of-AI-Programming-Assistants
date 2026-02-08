class MinHeap {
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
        const min = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._bubbleDown(0);
        return min;
    }

    peek() {
        return this.isEmpty() ? null : this.heap[0];
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

var smallestRange = function(nums) {
    const k = nums.length;
    const minHeap = new MinHeap();
    let maxVal = -Infinity;

    for (let i = 0; i < k; i++) {
        minHeap.push([nums[i][0], i, 0]);
        maxVal = Math.max(maxVal, nums[i][0]);
    }

    let rangeStart = 0;
    let rangeEnd = Infinity;
    let minRange = Infinity;

    while (minHeap.size() === k) {
        const [val, listIdx, elementIdx] = minHeap.pop();

        if (maxVal - val < minRange) {
            minRange = maxVal - val;
            rangeStart = val;
            rangeEnd = maxVal;
        }

        if (elementIdx + 1 < nums[listIdx].length) {
            const nextVal = nums[listIdx][elementIdx + 1];
            minHeap.push([nextVal, listIdx, elementIdx + 1]);
            maxVal = Math.max(maxVal, nextVal);
        }
    }

    return [rangeStart, rangeEnd];
};