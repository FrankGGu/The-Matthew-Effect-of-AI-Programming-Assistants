class MaxHeap {
    constructor() {
        this.heap = [];
    }

    push(val) {
        this.heap.push(val);
        this._bubbleUp(this.heap.length - 1);
    }

    pop() {
        if (this.heap.length === 0) return undefined;
        if (this.heap.length === 1) return this.heap.pop();

        const max = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._bubbleDown(0);
        return max;
    }

    peek() {
        return this.heap.length > 0 ? this.heap[0] : undefined;
    }

    get size() {
        return this.heap.length;
    }

    _bubbleUp(index) {
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
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

var mostFrequentIDs = function(nums, freqs) {
    const id_to_freq = new Map();
    const freq_to_count = new Map();
    const maxHeap = new MaxHeap();

    const results = [];

    for (let i = 0; i < nums.length; i++) {
        const id = nums[i];
        const delta_freq = freqs[i];

        const old_freq = id_to_freq.get(id) || 0;
        const new_freq = old_freq + delta_freq;

        if (old_freq > 0) {
            freq_to_count.set(old_freq, freq_to_count.get(old_freq) - 1);
        }

        id_to_freq.set(id, new_freq);

        if (new_freq > 0) {
            freq_to_count.set(new_freq, (freq_to_count.get(new_freq) || 0) + 1);
            maxHeap.push(new_freq);
        }

        while (maxHeap.size > 0 && (freq_to_count.get(maxHeap.peek()) || 0) === 0) {
            maxHeap.pop();
        }

        results.push(maxHeap.peek() || 0);
    }

    return results;
};