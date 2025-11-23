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

    peek() {
        return this.heap[0];
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    _compare(a, b) {
        // Compare by processing time, then by original index
        if (a[0] !== b[0]) {
            return a[0] < b[0];
        }
        return a[1] < b[1];
    }

    _bubbleUp(index) {
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            if (this._compare(this.heap[index], this.heap[parentIndex])) {
                [this.heap[index], this.heap[parentIndex]] = [this.heap[parentIndex], this.heap[index]];
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

            if (leftChildIndex <= lastIndex && this._compare(this.heap[leftChildIndex], this.heap[smallestIndex])) {
                smallestIndex = leftChildIndex;
            }

            if (rightChildIndex <= lastIndex && this._compare(this.heap[rightChildIndex], this.heap[smallestIndex])) {
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

var getOrder = function(tasks) {
    const n = tasks.length;
    const augmentedTasks = [];
    for (let i = 0; i < n; i++) {
        augmentedTasks.push([tasks[i][0], tasks[i][1], i]);
    }

    augmentedTasks.sort((a, b) => a[0] - b[0]);

    const result = [];
    const minHeap = new MinHeap();
    let currentTime = 0;
    let taskPointer = 0;

    while (result.length < n) {
        while (taskPointer < n && augmentedTasks[taskPointer][0] <= currentTime) {
            minHeap.push([augmentedTasks[taskPointer][1], augmentedTasks[taskPointer][2]]);
            taskPointer++;
        }

        if (!minHeap.isEmpty()) {
            const [processingTime, originalIndex] = minHeap.pop();
            currentTime += processingTime;
            result.push(originalIndex);
        } else {
            if (taskPointer < n) {
                currentTime = augmentedTasks[taskPointer][0];
            }
        }
    }

    return result;
};