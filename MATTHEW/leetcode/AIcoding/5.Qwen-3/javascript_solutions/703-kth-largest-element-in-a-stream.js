var KthLargest = function (k, nums) {
    this.k = k;
    this.heap = nums;
    this.buildHeap();
};

KthLargest.prototype.buildHeap = function () {
    for (let i = Math.floor(this.heap.length / 2); i >= 0; i--) {
        this.heapify(i);
    }
};

KthLargest.prototype.heapify = function (i) {
    let left = 2 * i + 1;
    let right = 2 * i + 2;
    let smallest = i;

    if (left < this.heap.length && this.heap[left] < this.heap[smallest]) {
        smallest = left;
    }

    if (right < this.heap.length && this.heap[right] < this.heap[smallest]) {
        smallest = right;
    }

    if (smallest !== i) {
        [this.heap[i], this.heap[smallest]] = [this.heap[smallest], this.heap[i]];
        this.heapify(smallest);
    }
};

KthLargest.prototype.add = function (val) {
    this.heap.push(val);
    this.heapify(0);

    while (this.heap.length > this.k) {
        this.heap[0] = this.heap[this.heap.length - 1];
        this.heap.pop();
        this.heapify(0);
    }

    return this.heap[0];
};