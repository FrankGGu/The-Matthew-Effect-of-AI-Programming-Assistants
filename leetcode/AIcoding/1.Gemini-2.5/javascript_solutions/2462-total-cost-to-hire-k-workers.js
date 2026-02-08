class MinPriorityQueue {
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
            let parentIndex = Math.floor((index - 1) / 2);
            if (this.heap[parentIndex] > this.heap[index]) {
                [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
                index = parentIndex;
            } else {
                break;
            }
        }
    }

    _sinkDown(index) {
        let leftChildIndex = 2 * index + 1;
        let rightChildIndex = 2 * index + 2;
        let smallestIndex = index;

        if (leftChildIndex < this.heap.length && this.heap[leftChildIndex] < this.heap[smallestIndex]) {
            smallestIndex = leftChildIndex;
        }

        if (rightChildIndex < this.heap.length && this.heap[rightChildIndex] < this.heap[smallestIndex]) {
            smallestIndex = rightChildIndex;
        }

        if (smallestIndex !== index) {
            [this.heap[index], this.heap[smallestIndex]] = [this.heap[smallestIndex], this.heap[index]];
            this._sinkDown(smallestIndex);
        }
    }
}

var totalCost = function(costs, k, candidates) {
    const pq1 = new MinPriorityQueue();
    const pq2 = new MinPriorityQueue();

    let left = 0;
    let right = costs.length - 1;
    let totalCost = 0;

    for (let i = 0; i < candidates; i++) {
        if (left <= right) {
            pq1.push(costs[left]);
            left++;
        } else {
            break;
        }
    }

    for (let i = 0; i < candidates; i++) {
        if (left <= right) {
            pq2.push(costs[right]);
            right--;
        } else {
            break;
        }
    }

    for (let i = 0; i < k; i++) {
        const cost1 = pq1.isEmpty() ? Infinity : pq1.peek();
        const cost2 = pq2.isEmpty() ? Infinity : pq2.peek();

        if (cost1 <= cost2) {
            totalCost += pq1.pop();
            if (left <= right) {
                pq1.push(costs[left]);
                left++;
            }
        } else {
            totalCost += pq2.pop();
            if (left <= right) {
                pq2.push(costs[right]);
                right--;
            }
        }
    }

    return totalCost;
};