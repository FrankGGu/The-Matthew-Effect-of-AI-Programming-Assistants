class PriorityQueue {
    constructor(comparator = (a, b) => a - b) {
        this.heap = [];
        this.comparator = comparator;
    }

    _parent(i) {
        return Math.floor((i - 1) / 2);
    }

    _leftChild(i) {
        return 2 * i + 1;
    }

    _rightChild(i) {
        return 2 * i + 2;
    }

    _swap(i, j) {
        [this.heap[i], this.heap[j]] = [this.heap[j], this.heap[i]];
    }

    _heapifyUp() {
        let i = this.heap.length - 1;
        while (i > 0 && this.comparator(this.heap[i], this.heap[this._parent(i)]) < 0) {
            this._swap(i, this._parent(i));
            i = this._parent(i);
        }
    }

    _heapifyDown() {
        let i = 0;
        let n = this.heap.length;
        while (true) {
            let left = this._leftChild(i);
            let right = this._rightChild(i);
            let smallest = i;

            if (left < n && this.comparator(this.heap[left], this.heap[smallest]) < 0) {
                smallest = left;
            }
            if (right < n && this.comparator(this.heap[right], this.heap[smallest]) < 0) {
                smallest = right;
            }

            if (smallest !== i) {
                this._swap(i, smallest);
                i = smallest;
            } else {
                break;
            }
        }
    }

    enqueue(element) {
        this.heap.push(element);
        this._heapifyUp();
    }

    dequeue() {
        if (this.isEmpty()) {
            return undefined;
        }
        if (this.heap.length === 1) {
            return this.heap.pop();
        }

        const root = this.heap[0];
        this.heap[0] = this.heap.pop();
        this._heapifyDown();
        return root;
    }

    front() {
        if (this.isEmpty()) {
            return undefined;
        }
        return { element: this.heap[0] };
    }

    isEmpty() {
        return this.heap.length === 0;
    }
}

class StockPrice {
    constructor() {
        this.prices = new Map();
        this.latestTimestamp = 0;

        // Min-Heap comparator for [price, timestamp]
        // Sorts by price in ascending order
        const minComparator = (a, b) => a[0] - b[0];
        this.minHeap = new PriorityQueue(minComparator);

        // Max-Heap comparator for [price, timestamp]
        // Sorts by price in descending order
        const maxComparator = (a, b) => b[0] - a[0];
        this.maxHeap = new PriorityQueue(maxComparator);
    }

    update(timestamp, price) {
        this.prices.set(timestamp, price);
        this.latestTimestamp = Math.max(this.latestTimestamp, timestamp);
        this.minHeap.enqueue([price, timestamp]);
        this.maxHeap.enqueue([price, timestamp]);
    }

    current() {
        return this.prices.get(this.latestTimestamp);
    }

    maximum() {
        while (true) {
            const [price, timestamp] = this.maxHeap.front().element;
            if (this.prices.get(timestamp) === price) {
                return price;
            }
            this.maxHeap.dequeue();
        }
    }

    minimum() {
        while (true) {
            const [price, timestamp] = this.minHeap.front().element;
            if (this.prices.get(timestamp) === price) {
                return price;
            }
            this.minHeap.dequeue();
        }
    }
}