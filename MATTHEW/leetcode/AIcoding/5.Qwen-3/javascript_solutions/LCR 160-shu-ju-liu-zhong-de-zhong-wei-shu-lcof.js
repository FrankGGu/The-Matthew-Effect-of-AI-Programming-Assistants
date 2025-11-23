var MedianFinder = function() {
    this.small = new MaxHeap();
    this.large = new MinHeap();
};

MedianFinder.prototype.addNum = function(num) {
    if (this.small.isEmpty() || num <= this.small.peek()) {
        this.small.push(num);
    } else {
        this.large.push(num);
    }

    if (this.small.size() > this.large.size() + 1) {
        this.large.push(this.small.pop());
    } else if (this.large.size() > this.small.size()) {
        this.small.push(this.large.pop());
    }
};

MedianFinder.prototype.findMedian = function() {
    if (this.small.size() === this.large.size()) {
        return (this.small.peek() + this.large.peek()) / 2;
    } else {
        return this.small.peek();
    }
};

function MaxHeap() {
    this.heap = [];
}

MaxHeap.prototype.push = function(value) {
    this.heap.push(value);
    this.bubbleUp(this.heap.length - 1);
};

MaxHeap.prototype.pop = function() {
    const top = this.heap[0];
    const last = this.heap.pop();
    if (this.heap.length > 0) {
        this.heap[0] = last;
        this.bubbleDown(0);
    }
    return top;
};

MaxHeap.prototype.peek = function() {
    return this.heap[0];
};

MaxHeap.prototype.size = function() {
    return this.heap.length;
};

MaxHeap.prototype.isEmpty = function() {
    return this.heap.length === 0;
};

MaxHeap.prototype.bubbleUp = function(index) {
    while (index > 0) {
        const parentIndex = Math.floor((index - 1) / 2);
        if (this.heap[parentIndex] >= this.heap[index]) break;
        [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
        index = parentIndex;
    }
};

MaxHeap.prototype.bubbleDown = function(index) {
    const length = this.heap.length;
    const element = this.heap[index];
    let leftChildIdx = 2 * index + 1;
    let rightChildIdx = 2 * index + 2;

    let largest = index;

    if (leftChildIdx < length && this.heap[leftChildIdx] > this.heap[largest]) {
        largest = leftChildIdx;
    }

    if (rightChildIdx < length && this.heap[rightChildIdx] > this.heap[largest]) {
        largest = rightChildIdx;
    }

    if (largest !== index) {
        [this.heap[index], this.heap[largest]] = [this.heap[largest], this.heap[index]];
        this.bubbleDown(largest);
    }
};

function MinHeap() {
    this.heap = [];
}

MinHeap.prototype.push = function(value) {
    this.heap.push(value);
    this.bubbleUp(this.heap.length - 1);
};

MinHeap.prototype.pop = function() {
    const top = this.heap[0];
    const last = this.heap.pop();
    if (this.heap.length > 0) {
        this.heap[0] = last;
        this.bubbleDown(0);
    }
    return top;
};

MinHeap.prototype.peek = function() {
    return this.heap[0];
};

MinHeap.prototype.size = function() {
    return this.heap.length;
};

MinHeap.prototype.isEmpty = function() {
    return this.heap.length === 0;
};

MinHeap.prototype.bubbleUp = function(index) {
    while (index > 0) {
        const parentIndex = Math.floor((index - 1) / 2);
        if (this.heap[parentIndex] <= this.heap[index]) break;
        [this.heap[parentIndex], this.heap[index]] = [this.heap[index], this.heap[parentIndex]];
        index = parentIndex;
    }
};

MinHeap.prototype.bubbleDown = function(index) {
    const length = this.heap.length;
    const element = this.heap[index];
    let leftChildIdx = 2 * index + 1;
    let rightChildIdx = 2 * index + 2;

    let smallest = index;

    if (leftChildIdx < length && this.heap[leftChildIdx] < this.heap[smallest]) {
        smallest = leftChildIdx;
    }

    if (rightChildIdx < length && this.heap[rightChildIdx] < this.heap[smallest]) {
        smallest = rightChildIdx;
    }

    if (smallest !== index) {
        [this.heap[index], this.heap[smallest]] = [this.heap[smallest], this.heap[index]];
        this.bubbleDown(smallest);
    }
};