var smallestRange = function(nums) {
    const minHeap = new MinHeap();
    let max = -Infinity;
    let rangeStart = 0, rangeEnd = Infinity;

    for (let i = 0; i < nums.length; i++) {
        const num = nums[i][0];
        minHeap.insert([num, i, 0]);
        max = Math.max(max, num);
    }

    while (minHeap.size() === nums.length) {
        const [min, listIndex, elementIndex] = minHeap.extractMin();
        if (max - min < rangeEnd - rangeStart) {
            rangeStart = min;
            rangeEnd = max;
        }
        if (elementIndex + 1 < nums[listIndex].length) {
            const nextNum = nums[listIndex][elementIndex + 1];
            minHeap.insert([nextNum, listIndex, elementIndex + 1]);
            max = Math.max(max, nextNum);
        }
    }

    return [rangeStart, rangeEnd];
};

class MinHeap {
    constructor() {
        this.heap = [];
    }

    size() {
        return this.heap.length;
    }

    insert(val) {
        this.heap.push(val);
        this.bubbleUp(this.heap.length - 1);
    }

    bubbleUp(index) {
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

    extractMin() {
        const min = this.heap[0];
        const last = this.heap.pop();
        if (this.heap.length > 0) {
            this.heap[0] = last;
            this.sinkDown(0);
        }
        return min;
    }

    sinkDown(index) {
        const left = 2 * index + 1;
        const right = 2 * index + 2;
        let smallest = index;

        if (left < this.heap.length && this.heap[left][0] < this.heap[smallest][0]) {
            smallest = left;
        }
        if (right < this.heap.length && this.heap[right][0] < this.heap[smallest][0]) {
            smallest = right;
        }

        if (smallest !== index) {
            [this.heap[index], this.heap[smallest]] = [this.heap[smallest], this.heap[index]];
            this.sinkDown(smallest);
        }
    }
}