function minOperations(nums) {
    let sum = nums.reduce((a, b) => a + b, 0);
    let target = sum / 2;
    let count = 0;
    let maxHeap = new MaxHeap();

    for (let num of nums) {
        maxHeap.push(num);
    }

    while (sum > target) {
        let max = maxHeap.pop();
        sum -= max;
        max /= 2;
        sum += max;
        count++;
        maxHeap.push(max);
    }

    return count;
}

class MaxHeap {
    constructor() {
        this.heap = [];
    }

    push(value) {
        this.heap.push(value);
        this.bubbleUp(this.heap.length - 1);
    }

    pop() {
        const max = this.heap[0];
        const end = this.heap.pop();
        if (this.heap.length > 0) {
            this.heap[0] = end;
            this.bubbleDown(0);
        }
        return max;
    }

    bubbleUp(index) {
        const parentIndex = Math.floor((index - 1) / 2);
        if (parentIndex < 0) return;
        if (this.heap[parentIndex] < this.heap[index]) {
            [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
            this.bubbleUp(parentIndex);
        }
    }

    bubbleDown(index) {
        const leftChildIndex = 2 * index + 1;
        const rightChildIndex = 2 * index + 2;
        let largest = index;

        if (leftChildIndex < this.heap.length && this.heap[leftChildIndex] > this.heap[largest]) {
            largest = leftChildIndex;
        }

        if (rightChildIndex < this.heap.length && this.heap[rightChildIndex] > this.heap[largest]) {
            largest = rightChildIndex;
        }

        if (largest !== index) {
            [this.heap[index], this.heap[largest]] = [this.heap[largest], this.heap[index]];
            this.bubbleDown(largest);
        }
    }
}