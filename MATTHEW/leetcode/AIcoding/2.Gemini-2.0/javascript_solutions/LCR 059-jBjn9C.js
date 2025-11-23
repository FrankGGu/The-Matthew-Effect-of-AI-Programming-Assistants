var KthLargest = function(k, nums) {
    this.k = k;
    this.heap = [];
    for (let num of nums) {
        this.add(num);
    }
};

KthLargest.prototype.add = function(val) {
    this.heap.push(val);
    this.heap.sort((a, b) => a - b);
    while (this.heap.length > this.k) {
        this.heap.shift();
    }
    return this.heap[0];
};