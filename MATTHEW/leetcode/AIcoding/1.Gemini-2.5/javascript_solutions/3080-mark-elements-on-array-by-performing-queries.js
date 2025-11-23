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
            if (this.heap[parentIndex][0] <= this.heap[index][0]) {
                break;
            }
            [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
            index = parentIndex;
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

var markElements = function(nums, queries) {
    const n = nums.length;
    const marked = new Array(n).fill(false);
    let currentSum = 0;
    const answer = [];

    const minHeap = new MinHeap();
    for (let i = 0; i < n; i++) {
        minHeap.push([nums[i], i]);
    }

    for (const query of queries) {
        const indexToMark = query[0];
        let k = query[1];

        if (!marked[indexToMark]) {
            currentSum += nums[indexToMark];
            marked[indexToMark] = true;
        }

        while (k > 0 && !minHeap.isEmpty()) {
            const [val, originalIndex] = minHeap.pop();
            if (!marked[originalIndex]) {
                currentSum += val;
                marked[originalIndex] = true;
                k--;
            }
        }
        answer.push(currentSum);
    }

    return answer;
};