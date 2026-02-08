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
        this._sinkDown(0);
        return min;
    }

    peek() {
        if (this.isEmpty()) {
            return undefined;
        }
        return this.heap[0];
    }

    isEmpty() {
        return this.heap.length === 0;
    }

    _bubbleUp(index) {
        while (index > 0) {
            const parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[parentIndex] > this.heap[index]) {
                [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
                index = parentIndex;
            } else {
                break;
            }
        }
    }

    _sinkDown(index) {
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

class DinnerPlates {
    constructor(capacity) {
        this.capacity = capacity;
        this.stacks = [];
        this.available = new MinHeap();
        this.rightmostNonEmptyStack = -1;
    }

    push(val) {
        let targetIdx;

        // Clean up stale or full indices from the heap
        let currentPeek = this.available.peek();
        while (!this.available.isEmpty() && (currentPeek >= this.stacks.length || this.stacks[currentPeek].length === this.capacity)) {
            this.available.pop();
            currentPeek = this.available.peek();
        }

        if (this.available.isEmpty()) {
            targetIdx = this.stacks.length;
        } else {
            targetIdx = this.available.peek();
        }

        // If targetIdx is a new stack index, create the stack
        if (targetIdx === this.stacks.length) {
            this.stacks.push([]);
        }

        this.stacks[targetIdx].push(val);
        this.rightmostNonEmptyStack = Math.max(this.rightmostNonEmptyStack, targetIdx);

        // If the stack is still not full, add/keep its index in the available heap
        if (this.stacks[targetIdx].length < this.capacity) {
            this.available.push(targetIdx);
        }
    }

    pop() {
        // Find the rightmost non-empty stack
        while (this.rightmostNonEmptyStack >= 0 && this.stacks[this.rightmostNonEmptyStack].length === 0) {
            this.rightmostNonEmptyStack--;
        }

        if (this.rightmostNonEmptyStack < 0) {
            return -1;
        }

        const val = this.stacks[this.rightmostNonEmptyStack].pop();

        // If the stack just became not full, add its index to available
        if (this.stacks[this.rightmostNonEmptyStack].length === this.capacity - 1) {
            this.available.push(this.rightmostNonEmptyStack);
        }

        return val;
    }

    popAtStack(index) {
        if (index >= this.stacks.length || this.stacks[index].length === 0) {
            return -1;
        }

        const val = this.stacks[index].pop();

        // If the stack just became not full, add its index to available
        if (this.stacks[index].length === this.capacity - 1) {
            this.available.push(index);
        }

        return val;
    }
}