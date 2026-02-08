var KthLargest = function(k, nums) {
    this.k = k;
    this.minHeap = new MinPriorityQueue();
    for (const num of nums) {
        this.add(num);
    }
};

KthLargest.prototype.add = function(val) {
    this.minHeap.enqueue(val);
    if (this.minHeap.size() > this.k) {
        this.minHeap.dequeue();
    }
    return this.minHeap.front().element;
};