class KthLargest {
    constructor(k, nums) {
        this.k = k;
        this.minHeap = [];
        nums.forEach(num => this.add(num));
    }

    add(val) {
        if (this.minHeap.length < this.k) {
            this.minHeap.push(val);
            this.minHeap.sort((a, b) => a - b);
        } else if (val > this.minHeap[0]) {
            this.minHeap[0] = val;
            this.minHeap.sort((a, b) => a - b);
        }
        return this.minHeap[0];
    }
}