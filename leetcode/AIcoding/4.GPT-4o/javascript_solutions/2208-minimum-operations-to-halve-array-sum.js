function minOperations(nums) {
    let total = nums.reduce((a, b) => a + b, 0);
    let target = total / 2;
    let maxHeap = new MaxHeap(nums);
    let operations = 0;

    while (total > target) {
        let largest = maxHeap.extractMax();
        total -= largest / 2;
        maxHeap.insert(largest / 2);
        operations++;
    }

    return operations;
}

class MaxHeap {
    constructor(arr) {
        this.heap = arr;
        this.buildHeap();
    }

    buildHeap() {
        for (let i = Math.floor(this.heap.length / 2) - 1; i >= 0; i--) {
            this.siftDown(i);
        }
    }

    siftDown(index) {
        const left = 2 * index + 1;
        const right = 2 * index + 2;
        let largest = index;

        if (left < this.heap.length && this.heap[left] > this.heap[largest]) {
            largest = left;
        }
        if (right < this.heap.length && this.heap[right] > this.heap[largest]) {
            largest = right;
        }
        if (largest !== index) {
            [this.heap[index], this.heap[largest]] = [this.heap[largest], this.heap[index]];
            this.siftDown(largest);
        }
    }

    extractMax() {
        if (this.heap.length === 0) return null;
        const max = this.heap[0];
        this.heap[0] = this.heap.pop();
        this.siftDown(0);
        return max;
    }

    insert(value) {
        this.heap.push(value);
        this.siftUp(this.heap.length - 1);
    }

    siftUp(index) {
        while (index > 0) {
            const parent = Math.floor((index - 1) / 2);
            if (this.heap[index] > this.heap[parent]) {
                [this.heap[index], this.heap[parent]] = [this.heap[parent], this.heap[index]];
                index = parent;
            } else {
                break;
            }
        }
    }
}